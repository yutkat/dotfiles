export EDITOR=nvim
alias vi='snvim'
alias sv="sudo $EDITOR"
alias v='nvim -c "PossessionLoadCurrent"'

# Sandboxed Neovim (firejail filesystem isolation). Network mode via SNVIM_NET:
#   unset / proxy : file isolation + cooperative allowlist proxy, FAST   [default]
#   wall          : Phase 2 hard wall (own netns, kernel egress block); SLOW startup
#                   (~1.6s firejail netns setup). Used by snvim-wall + plugupdate.
#   1 / open      : file isolation + unrestricted network
#   none          : file isolation + no network at all (offline)
# See docs/superpowers/specs/2026-06-09-neovim-runtime-sandbox-design.md
function snvim() {
	local cwd firejail_bin proxy
	local netfile="${XDG_CONFIG_HOME:-$HOME/.config}/firejail/nvim-egress.net"
	local -a firejail_args proxy_env

	if [ -x /run/wrappers/bin/firejail ]; then
		firejail_bin=/run/wrappers/bin/firejail
	else
		firejail_bin=/usr/bin/firejail
	fi

	cwd="${PWD:A}"
	firejail_args=(--quiet --profile="${XDG_CONFIG_HOME:-$HOME/.config}/firejail/nvim.profile")
	if [ "$cwd" != "$HOME" ] && [ "$cwd" != "/" ]; then
		firejail_args+=(--read-write="$cwd")
	fi

	case "${SNVIM_NET:-proxy}" in
		none)
			firejail_args+=(--net=none)
			;;
		1 | open)
			;;
		wall)
			# Phase 2 hard wall (SLOW ~1.6s firejail netns setup). Own network
			# namespace whose only reachable destination is the allowlist proxy;
			# raw-socket connect() is dropped by the netfilter. For plugin updates /
			# untrusted work (snvim-wall, plugupdate). Falls back to cooperative
			# proxy env if the bridge or proxy is unavailable.
			if ! systemctl --user is-active --quiet tinyproxy-nvim 2>/dev/null; then
				print -u2 "snvim: tinyproxy-nvim not running -> egress UNFILTERED (file isolation still on)"
			elif ip link show nvbr0 >/dev/null 2>&1 && [ -r "$netfile" ]; then
				# Random host octet avoids clashes between concurrent instances.
				firejail_args+=(
					--net=nvbr0
					--ip="10.123.45.$(((RANDOM % 250) + 2))"
					--netfilter="$netfile"
				)
				proxy="http://10.123.45.1:8888"
			else
				print -u2 "snvim: egress bridge nvbr0 unavailable -> proxy-env mode only"
				proxy="http://127.0.0.1:8888"
			fi
			;;
		*)
			# Default (FAST): file isolation + cooperative allowlist proxy via env.
			# Shares the host net namespace (no netns setup cost) so the loopback
			# proxy is reachable. Cooperative only -- raw-socket exfil is not blocked
			# here; that is what `wall` mode (plugin updates) is for.
			if systemctl --user is-active --quiet tinyproxy-nvim 2>/dev/null; then
				proxy="http://127.0.0.1:8888"
			else
				print -u2 "snvim: tinyproxy-nvim not running -> egress UNFILTERED (file isolation still on)"
			fi
			;;
	esac

	if [ -n "$proxy" ]; then
		proxy_env=(
			HTTPS_PROXY="$proxy" HTTP_PROXY="$proxy" ALL_PROXY="$proxy"
			https_proxy="$proxy" http_proxy="$proxy" all_proxy="$proxy"
			NO_PROXY= no_proxy=
		)
	fi

	# firejail returns a teardown-polluted exit status (observed: 2) when LSP
	# servers or formatter jobs still linger in its PID namespace as nvim exits
	# cleanly. nvim itself exits 0 here, so just drop firejail's spurious 2.
	env "${proxy_env[@]}" "$firejail_bin" "${firejail_args[@]}" nvim "$@"
	local ec=$?
	[ "$ec" -eq 2 ] && ec=0
	return $ec
}

alias snvim-net='SNVIM_NET=1 snvim'
alias snvim-offline='SNVIM_NET=none snvim'
alias snvim-wall='SNVIM_NET=wall snvim'
if (( $+functions[compdef] )); then
	compdef snvim=nvim
fi

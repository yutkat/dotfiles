# Process Detection

- Do not identify a running program by the basename of its resolved executable path (`/proc/<pid>/exe` or equivalents like WezTerm's `get_foreground_process_name`)
- Version-managed installs resolve through symlinks (e.g. `~/.local/bin/claude` -> `~/.local/share/claude/versions/2.1.199`), so the resolved basename is a version number, not the command name
- Match the comm name and `argv[0]` first (they keep the invoked name); use the executable path only as an additional candidate
- Interpreter-run scripts lose the invoked name in comm and `argv[0]` too: `#!/usr/bin/env node` scripts show comm/`argv[0]` as `node` with the script path in `argv[1]`, so also compare the script basename when `argv[0]` is an interpreter

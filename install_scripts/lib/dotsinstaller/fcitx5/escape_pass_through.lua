local fcitx = require("fcitx")

fcitx.watchEvent(fcitx.EventType.KeyEvent, "Handler")

-- selene: allow(unused_variable)
---@diagnostic disable-next-line: unused-function, unused-local
function Handler(sym, state, release)
	if ((sym == 65307 and state == 0) or (sym == 91 and state == 4)) and not release then
		fcitx.setCurrentInputMethod("keyboard-us")
	end
	return false
end

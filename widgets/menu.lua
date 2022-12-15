local _M            = {}

local awful         = require 'awful'
local hotkeys_popup = require 'awful.hotkeys_popup'
local beautiful     = require 'beautiful'
local apps          = require 'config.apps'
local common        = require("modules.common")
local awesome       = awesome

_M.awesomemenu      = {
	{ 'hotkeys', function()
		hotkeys_popup.show_help(nil, awful.screen.focused())
	end },
	{ 'restart', awesome.restart },
}

_M.screenshot_menu  = {
	{ "Selection", common.screenshot_selection_fn },
	{ "Window", common.screenshot_window_fn },
}

_M.power_menu       = {
	{ "Suspend/Sleep", function()
		awful.util.spawn_with_shell("sudo systemctl suspend")
	end },
	{ "Log out", function()
		awful.util.spawn_with_shell("sudo service lightdm restart")
	end },
	{ "Shutdown", function()
		os.execute("shutdown -P -h now")
	end },
	{ "Reboot", function()
		os.execute("reboot")
	end },
}

_M.mainmenu         = awful.menu {
	items = {
		{ 'awesome', _M.awesomemenu, beautiful.awesome_icon },
		{ 'open terminal', apps.terminal }
	}
}

_M.launcher         = awful.widget.launcher {
	image = beautiful.awesome_icon,
	menu  = _M.mainmenu
}

return _M

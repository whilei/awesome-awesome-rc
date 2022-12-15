local awful   = require("awful")
local naughty = require("naughty")
local cmds    = require("config.cmds")
return {

	screenshot_selection_fn = function()
		awful.util.mymainmenu:hide()
		awful.spawn.easy_async_with_shell(cmds.screenshot_select, function()
			naughty.notify({ text = "Screenshot of selection OK", timeout = 2, bg = "#058B04", fg = "#ffffff", position = "bottom_middle" })
		end)
	end,
	screenshot_window_fn    = function()
		awful.util.mymainmenu:hide()
		awful.util.spawn_with_shell(cmds.screenshot_window)
		naughty.notify({ text = "Screenshot of window OK", timeout = 2, bg = "#058B04", fg = "#ffffff", position = "bottom_middle" })
	end,
	
	fullscreen_fn           = function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end
}
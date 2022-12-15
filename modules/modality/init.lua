local modalbind     = require("modalbind")
local awful         = require("awful")
local beautiful     = require("beautiful")
local lain          = require("lain")
local naughty       = require("naughty")
local revelation    = require("revelation")
local hints         = require("hints")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local common        = require("modules.common")
local awesome       = awesome
local client        = client

modalbind.init()
modalbind.set_location("centered")
modalbind.hide_default_options()

local imodal_main
local imodal_awesomewm
local imodal_client
local imodal_client_placement
local imodal_layouts
local imodal_power
local imodal_screenshot
local imodal_tag
local imodal_toggle
local imodal_widgets

local to_main_menu      = { "<", function()
	modalbind.grab { keymap = imodal_main, name = "", stay_in_mode = false }
end, "back" }

local imodal_separator  = { "separator", "" }

imodal_awesomewm        = {
	{ "h", hotkeys_popup.show_help, "Hotkeys" },
	{ "m", function()
		awful.util.mymainmenu:show()
	end, "Menu" },
	{ "r", awesome.restart, "Restart" },
	imodal_separator,
	to_main_menu,
}

imodal_client           = {

	{ "c", function()
		modalbind.grab { keymap = imodal_client_placement, name = "Client Placement", stay_in_mode = true, hide_default_options = true }
	end, "➔ Position Client" },

	imodal_separator,

	{ "h", function()
		awful.client.focus.global_bydirection("left")
		if client.focus then
			client.focus:raise()
		end
	end, "Focus client ← left" },
	{ "l", function()
		awful.client.focus.global_bydirection("right")
		if client.focus then
			client.focus:raise()
		end
	end, "Focus client → right" },
	{ "j", function()
		awful.client.focus.global_bydirection("down")
		if client.focus then
			client.focus:raise()
		end
	end, "Focus client ↓ down" },
	{ "k", function()
		awful.client.focus.global_bydirection("up")
		if client.focus then
			client.focus:raise()
		end
	end, "Focus client ↑ up" },

	imodal_separator,

	{ "f", function()
		if not client.focus then
			return
		end
		client.focus.floating = not client.focus.floating
		client.focus:raise()
	end, "Float" },

	{ "F", function()
		if not client.focus then
			return
		end
		fullscreen_fn(client.focus)
	end, "Fullscreen" },

	{ "m", function()
		if not client.focus then
			return
		end
		client.focus.maximized = not client.focus.maximized
		client.focus:raise()
	end, "Maximize" },

	{ "o", function()
		if not client.focus then
			return
		end
		client.focus.ontop = not client.focus.ontop
	end, "On top" },

	{ "s", function()
		if not client.focus then
			return
		end
		client.focus.sticky = not client.focus.sticky
	end, "Sticky" },

	imodal_separator,

	{ "t", function()
		if not client.focus then
			return
		end
		client.focus:move_to_screen()
	end, "Throw to next screen" },

	{ "T", function()
		if not client.focus then
			return
		end
		awful.titlebar.toggle(client.focus)
	end, "Titlebar (toggle)" },

	imodal_separator,

	--{ "m", function()
	--	if not client.focus then return end
	--	lain.util.magnify_client(client.focus)
	--end, "Magnify"},

	--{ "p", function()
	--	local c = client.focus;
	--	if client.focus.fullscreen then
	--		local geo
	--		geo = c:geometry()
	--		local geo_scr
	--		geo_scr = c.screen.geometry
	--
	--		geo.width = geo_scr.width / 4
	--		geo.height = geo_scr.height / 3
	--
	--		c:geometry(geo)
	--		local f = awful.placement.right + awful.placement.bottom;
	--		f(c)
	--		c.ontop = true
	--		c.sticky = true
	--		c.fullscreen = true
	--		--c:raise()
	--	end
	--	--if client.focus.fullscreen then
	--	--	fullscreen_fn(client.focus)
	--	--else
	--	--	client.focus.disconnect_signal("request::geometry", awful.ewmh.geometry)
	--	--	fullscreen_fn(client.focus)
	--	--	client.focus.ontop = true
	--	--	client.focus.sticky = true
	--	--	client.connect_signal("request::geometry", awful.ewmh.geometry)
	--	--end
	--end, "Picture-in-picture (use on Fullscreen client)"},

	{ "*", function()
		if not client.focus then
			return
		end
		client.focus:swap(awful.client.getmaster())
	end, "Move to master" },

	{ "n", function()
		local cc = client.focus
		if not cc then
			return
		end
		awful.client.focus.history.previous()
		cc:lower()
		cc.minimized = true
	end, "Minimize client" },

	{ "r", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			client.focus = c
			c:raise()
		end
	end, "Restore (=unminimize) a random client" },

	{ "x", function()
		if not client.focus then
			return
		end
		client.focus:kill()
	end, "Kill" },

	imodal_separator,
	to_main_menu,
}

imodal_client_placement = {

	imodal_separator,

	{ "B", function()
		if not client.focus then
			return
		end ;
		client.focus.floating = true;
		client.focus.height   = client.focus.screen.workarea.height / 10 * 5;
		client.focus.width    = client.focus.screen.workarea.width / 10 * 5;
		awful.placement.bottom(client.focus)
	end, "Bottom [resized]" },
	{ "C", function()
		if not client.focus then
			return
		end ;
		client.focus.floating = true;
		awful.placement.scale(client.focus, { to_percent = 0.61 });
		awful.placement.centered(client.focus)
	end, "Center [resized]" },
	{ "L", function()
		if not client.focus then
			return
		end ;
		client.focus.floating = true;
		client.focus.height   = client.focus.screen.workarea.height / 10 * 8;
		client.focus.width    = client.focus.screen.workarea.width / 100 * 25;
		awful.placement.left(client.focus)
	end, "Left [resized]" },
	{ "R", function()
		if not client.focus then
			return
		end ;
		client.focus.floating = true;
		client.focus.height   = client.focus.screen.workarea.height / 10 * 8;
		client.focus.width    = client.focus.screen.workarea.width / 100 * 25;
		awful.placement.right(client.focus)
	end, "Right [resized]" },
	{ "T", function()
		if not client.focus then
			return
		end ;
		client.focus.floating = true;
		client.focus.height   = client.focus.screen.workarea.height / 10 * 5;
		client.focus.width    = client.focus.screen.workarea.width / 10 * 5;
		awful.placement.top(client.focus)
	end, "Top [resized]" },

	imodal_separator,

	{ "b", function()
		if not client.focus then
			return
		end ;
		client.focus.floating = true;
		awful.placement.bottom(client.focus)
	end, "Bottom" },
	{ "c", function()
		if not client.focus then
			return
		end ;
		client.focus.floating = true;
		awful.placement.centered(client.focus)
	end, "Center" },
	{ "l", function()
		if not client.focus then
			return
		end ;
		client.focus.floating = true;
		awful.placement.left(client.focus)
	end, "Left" },
	{ "r", function()
		if not client.focus then
			return
		end ;
		client.focus.floating = true;
		awful.placement.right(client.focus)
	end, "Right" },
	{ "t", function()
		if not client.focus then
			return
		end ;
		client.focus.floating = true;
		awful.placement.top(client.focus)
	end, "Top" },

	imodal_separator,

	{ "v", function()
		if not client.focus then
			return
		end ;
		client.focus.floating = true;
		client.focus.height   = client.focus.height + client.focus.screen.workarea.height / 10
	end, "Grow ↓" },
	{ "V", function()
		if not client.focus then
			return
		end ;
		client.focus.floating = true;
		client.focus.height   = client.focus.height - client.focus.screen.workarea.height / 10
	end, "Shrink ↑" },
	{ "+", function()
		if not client.focus then
			return
		end ;
		client.focus.floating = true;
		client.focus.width    = client.focus.width + client.focus.screen.workarea.height / 10
	end, "Grow →" },
	{ "-", function()
		if not client.focus then
			return
		end ;
		client.focus.floating = true;
		client.focus.width    = client.focus.width - client.focus.screen.workarea.height / 10
	end, "Shrink ←" },

	{ "H", function()
		if not client.focus then
			return
		end ;
		client.focus.floating = true;
		awful.placement.maximize_vertically(client.focus)
	end, "Height of work area" },
	{ "W", function()
		if not client.focus then
			return
		end ;
		client.focus.floating = true;
		awful.placement.maximize_horizontally(client.focus)
	end, "Width of work area" },
}

imodal_layouts          = {
	{ "b", function()
		awful.layout.set(ia_layout_bigscreen)
	end, "Big screen 4x4" },
	{ "c", function()
		awful.layout.set(lain.layout.centerwork)
	end, "Centerwork" },
	{ "f", function()
		awful.layout.set(awful.layout.suit.floating)
	end, "Floating" },
	{ "m", function()
		awful.layout.set(awful.layout.suit.magnifier)
	end, "Magnifier" },
	{ "t", function()
		awful.layout.set(awful.layout.suit.tile)
	end, "Tile" },
	{ "v", function()
		awful.layout.set(ia_layout_vcolumns)
	end, "Vertical columns" },
	--{ "Tab", function()
	--	awful.layout.set(layout_bling_mstab)
	--end, "MS-Tab"},
	imodal_separator,
	to_main_menu,
}

imodal_power            = {
	{ "l", function()
		awful.util.spawn_with_shell("sudo service lightdm restart")
	end, "Log out" },
	{ "s", function()
		awful.util.spawn_with_shell("sudo systemctl suspend")
	end, "Suspend" },
	imodal_separator,
	{ "P", function()
		awful.util.spawn_with_shell("shutdown -P -h now")
	end, "Shutdown" },
	{ "R", function()
		os.execute("reboot")
	end, "Reboot" },
	imodal_separator,
	to_main_menu,
}

imodal_screenshot       = {
	{ "s", common.screenshot_selection_fn, "Selection" },
	{ "w", common.screenshot_window_fn, "Window" },
	imodal_separator,
	to_main_menu,
}

imodal_tag              = {
	{ "1", function()
		local screen = awful.screen.focused()
		local tag    = screen.tags[1]
		if tag then
			tag:view_only()
		end
	end, "[1] - View Tag" },
	{ "2", function()
		local screen = awful.screen.focused()
		local tag    = screen.tags[2]
		if tag then
			tag:view_only()
		end
	end, "[2] - View Tag" },
	{ "3", function()
		local screen = awful.screen.focused()
		local tag    = screen.tags[3]
		if tag then
			tag:view_only()
		end
	end, "[3] - View Tag" },
	{ "4", function()
		local screen = awful.screen.focused()
		local tag    = screen.tags[4]
		if tag then
			tag:view_only()
		end
	end, "[4] - View Tag" },
	{ "5", function()
		local screen = awful.screen.focused()
		local tag    = screen.tags[5]
		if tag then
			tag:view_only()
		end
	end, "[5] - View Tag" },
	imodal_separator,
	{ "a", function()
		awful                                     .tag.add("NewTag", {
			screen = awful.screen.focused(),
			layout = awful.layout.suit.floating }):view_only()
	end, "Add tag" },
	{ "d", function()
		local t = awful.screen.focused().selected_tag
		if not t then
			return
		end
		t:delete()
	end, "Delete tag" },
	{ "n", awful.tag.viewnext, "Next tag" },
	{ "N", function()
		local c = client.focus
		if not c then
			return
		end

		local t = awful.tag.add(c.class, { screen = c.screen })
		c:tags({ t })
		t:view_only()
	end, "(move focused client to) New tag" },
	{ "p", awful.tag.viewprev, "Previous tag" },
	{ "r", function()
		awful.prompt.run {
			prompt       = "New tag name: ",
			textbox      = awful.screen.focused().mypromptbox.widget,
			exe_callback = function(new_name)
				if not new_name or #new_name == 0 then
					return
				end

				local t = awful.screen.focused().selected_tag
				if t then
					t.name = new_name
				end
			end
		}
	end, "Rename tag" },
	imodal_separator,
	to_main_menu,
}

imodal_toggle           = {
	{ "c", function()
		os.execute(invert_colors)
	end, "(Invert) Colors" },

	{ "i", function()
		os.execute("amixer -q set Capture toggle")
		beautiful.mic.update()
	end, "Microphone" },

	{ "m", function()
		os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
		beautiful.volume.update()
	end, "Mute" },

	{ "u", function()
		local scr = awful.screen.focused()
		if scr.selected_tag.gap > 0 then
			-- turn gaps off by setting to 0
			scr.selected_tag.gap = 0
		else
			scr.selected_tag.gap = scr.geometry.height / 20
		end
		awful.layout.arrange(scr)
		naughty.notify({ text = "Useless gaps set: " .. tostring(scr.selected_tag.gap), timeout = 2, bg = "#058B04", fg = "#ffffff", position = "bottom_middle" })
	end, "Useless gaps toggle" },

	imodal_separator,
	to_main_menu,
}

imodal_widgets          = {
	{ "d", function()
		my_calendar_widget.toggle()
	end, "Date = Toggle Calendar widget" },

	{ "w", function()
		my_weather.toggle()
	end, "Toggle Weather widget" }
}

imodal_main             = {
	{ "a", function()
		modalbind.grab { keymap = imodal_awesomewm, name = "AwesomeWM", stay_in_mode = false, hide_default_options = true }
	end, "➔ AwesomeWM" },

	{ "c", function()
		modalbind.grab { keymap = imodal_client, name = "Client", stay_in_mode = false, hide_default_options = true }
	end, "➔ Client" },

	{ "l", function()
		modalbind.grab { keymap = imodal_layouts, name = "Layouts", stay_in_mode = false, hide_default_options = true }
	end, "➔ Layout" },

	{ "s", function()
		modalbind.grab { keymap = imodal_screenshot, name = "Screenshot", stay_in_mode = false, hide_default_options = true }
	end, "➔ Screenshot" },

	{ "t", function()
		modalbind.grab { keymap = imodal_tag, name = "Tag", stay_in_mode = false, hide_default_options = true }
	end, "➔ Tag" },

	{ "w", function()
		modalbind.grab { keymap = imodal_widgets, name = "Widgets", stay_in_mode = false, hide_default_options = true }
	end, "➔ Widgets" },

	{ "x", function()
		modalbind.grab { keymap = imodal_toggle, name = "Toggle Settings", stay_in_mode = false, hide_default_options = true }
	end, "➔ Toggle Settings" },

	{ "P", function()
		modalbind.grab { keymap = imodal_power, name = "Power / User", stay_in_mode = false, hide_default_options = true }
	end, "➔ Power / User" },

	imodal_separator,

	{ "*", function()
		if not client.focus then
			return
		end
		client.focus:swap(awful.client.getmaster())
	end, "Move to client to master" },

	{ "i", function()
		hints.focus();
		client.focus:raise()
	end, "Jump-to h[i]nts" },

	{ "r", revelation, "Revelation" },
}
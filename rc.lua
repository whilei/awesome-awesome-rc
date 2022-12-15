-- awesome_mode: api-level=4:screen=on

-- load luarocks if installed
pcall(require, 'luarocks.loader')

-- load theme
local beautiful = require 'beautiful'
local gears     = require 'gears'
beautiful.init(gears.filesystem.get_themes_dir() .. 'default/theme.lua')

-- load configs
require 'config'
local awful         = require 'awful'
awful.util.terminal = config.apps.terminal

-- load key and mouse bindings
require 'bindings'

-- load rules
require 'rules'

-- load signals
require 'signals'

-- load modules
require 'modules'

local revelation = require("revelation")
revelation.init()

local hints = require("hints")
hints.init()

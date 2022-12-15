local _M    = {}

local awful = require 'awful'
local lain  = require 'lain'

_M.layouts  = {
	awful.layout.suit.tile,
	lain.layout.centerwork,
	awful.layout.suit.magnifier,
	awful.layout.suit.floating,
}

_M.tags     = { "❶", "❷", "❸", "❹", "❺" }

return _M

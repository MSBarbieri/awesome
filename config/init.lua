local utils = require("utils")
local keys_setup = require("config.keys")
local buttons_setup = require("config.mouse_buttons")
local rules = require("config.rules")
local tags_setup = require('config.tags')
local signals_setup = require("config.signals")
local M = {}

local Default = {
  apps = {
    terminal = 'kitty',
    editor = 'kitty nvim',
    browser = 'firefox',
    launcher = 'rofi -show drun',
  },
  keys = {
    mod = 'Mod4',
    alt = 'Mod1',
    ctrl = 'Control',
    sft = 'Shift',
  },
}

M.setup = function(opts)
  opts = opts or {}
  opts = utils.merge_table(Default, opts)

  local keys = keys_setup(opts)
  root.keys(keys.global)
  local buttons = buttons_setup(opts)
  tags_setup(opts)
  signals_setup(opts)
  rules.setup(opts, keys, buttons)
  -- rules.tag_rules(tags)

  awesome.emit_signal("loaded")
  return {
    keys, buttons
  }
end


return M

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
    editor = 'kitty ' .. os.getenv('HOME') .. '/.local/bin/tmux-sessionizer ' .. os.getenv('HOME') .. '/dev/repos/',
    browser = 'brave-browser',
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
  opts = utils.merge_table(opts, Default)

  terminal = opts.apps.terminal
  editor = opts.apps.editor
  editor_cmd = opts.apps.terminal .. opts.apps.editor

  local keys = keys_setup(opts)
  root.keys(keys.global)
  local buttons = buttons_setup(opts)
  local tags = tags_setup(opts)
  signals_setup(opts)
  rules.setup(opts, keys, buttons)
  -- rules.tag_rules(tags)

  return {
    keys, buttons
  }
end


return M

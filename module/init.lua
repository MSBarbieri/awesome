local utils = require("utils")
local notifications_setup = require('module.notifications')
local auto_start = require('module.auto-start')
local exit_screen_setup = require('module.exit-screen')
local decorate = require('module.decorate-client')
local backdrop = require('module.backdrop')
-- require('module.quake-terminal')

local Default = {
  apps = {
    lock = nil,
  },
  startup_scripts = {
    { cmd = 'picom --config=$HOME/.config/picom/picom.conf --experimental-backends' },
  }
}
local M = {}

M.setup = function(opts)
  opts = opts or {}
  opts = utils.merge_table(Default, opts)

  auto_start(opts)
  notifications_setup(opts)
  decorate(opts)
  backdrop(opts)
  exit_screen_setup(opts)

end

return M

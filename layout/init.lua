local awful = require('awful')
local vertical_panel = require('layout.vertical-panel')
local top_panel = require('layout.top-panel')
local signals = require('layout.signals')
local utils = require("utils")
-- Create a wibox for each screen and add it

local M = {}

local default = {
  opened = true,
  area = "twitch",
  enabled = true,
  position = "left"
}

function M.updateBarsVisibility(_)
  for s in screen do
    if s.selected_tag then
      local fullscreen = s.selected_tag.fullscreenMode
      -- Order matter here for shadow
      s.top_panel.visible = not fullscreen and M.state.enabled
      if s.left_panel then
        s.left_panel.visible = not fullscreen and M.state.enabled
      end
    end
  end
end

function M.setup(opts)
  opts = opts or {}
  M.state = utils.merge_table(default, opts)
  awful.screen.connect_for_each_screen(
    function(s)
      -- Create the left_panel
      s.top_panel = top_panel(M.state, s)
      s.left_panel = vertical_panel(M.state, s)

      signals.screen_signals(s, M.updateBarsVisibility)
    end
  )
  signals.setup_signals(M.updateBarsVisibility)
end

function M.toggle()
  M.state.enabled = not M.state.enabled
  M.updateBarsVisibility()
end

function M.toggle_info_panel()
  M.state.opened = not M.state.opened
  screen.primary:emit_signal('toggle_panel')
end

return M

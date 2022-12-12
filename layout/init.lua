local awful = require('awful')
local left_panel = require('layout.left-panel')
local top_panel = require('layout.top-panel')
local signals = require('layout.signals')
local utils = require("utils")
-- Create a wibox for each screen and add it

local M = {}

local default = {
  opened = true,
  area = "twitch",
  enabled = true,
}

local function updateBarsVisibility(_)
  for s in screen do
    if s.selected_tag then
      local fullscreen = s.selected_tag.fullscreenMode
      -- Order matter here for shadow
      s.top_panel.visible = not fullscreen and s.top_panel.enabled
      if s.left_panel then
        s.left_panel.visible = not fullscreen and s.left_panel.enabled
      end
    end
  end
end

M.setup = function(opts)
  opts = opts or {}
  opts = utils.merge_table(default, opts)
  awful.screen.connect_for_each_screen(
    function(s)
      if s.index == 1 then
        -- Create the left_panel
        s.top_panel = top_panel(opts, s)
        s.left_panel = left_panel(opts, s)
      else
        s.top_panel = top_panel(opts, s)
      end

      signals.screen_signals(s, updateBarsVisibility)
    end
  )
  signals.setup_signals(updateBarsVisibility)
end

return M

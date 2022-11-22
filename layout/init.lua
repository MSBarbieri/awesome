local awful = require('awful')
local left_panel = require('layout.left-panel')
local top_panel = require('layout.top-panel')
local setup_signals = require('layout.signals')
local dpi = require('beautiful').xresources.apply_dpi
local utils = require("utils")
-- Create a wibox for each screen and add it

local M = {}

local default = {
  opened = true,
  area = "twitch",
  enabled = true,
}

local function updateBarsVisibility(event)
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

      s:connect_signal('opened', function()
        s.top_panel.width = s.geometry.width - dpi(360)
        s.top_panel.x = s.geometry.x + dpi(360)
      end)
      s:connect_signal('closed', function()
        s.top_panel.width = s.geometry.width - dpi(80)
        s.top_panel.x = s.geometry.x + dpi(80)
      end)

      s:connect_signal('toggle_layout', function()
        s.top_panel.enabled = not s.top_panel.enabled
        s.left_panel.enabled = not s.left_panel.enabled
        updateBarsVisibility()
      end)
    end
  )
  setup_signals(updateBarsVisibility)
end

return M

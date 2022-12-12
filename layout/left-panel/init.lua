local wibox           = require('wibox')
local dpi             = require('beautiful').xresources.apply_dpi
local main_bar_widget = require('layout.left-panel.main_bar')
local info_bar_widget = require('layout.left-panel.info_bar')
local bottom_part     = require('layout.left-panel.bottom_part')

local left_panel = function(state, screen)
  local action_bar_width = dpi(80)
  local panel_content_width = dpi(360)

  local panel = wibox {
    screen = screen,
    width = action_bar_width,
    height = screen.geometry.height,
    x = screen.geometry.x,
    y = screen.geometry.y,
    ontop = true,
    bg = "#22222244",
  }

  panel.enabled = state.enabled

  local openPanel = function()
    panel:struts({
      left = panel_content_width
    })
    panel.width = panel_content_width
  end

  local closePanel = function()
    panel:struts({
      left = action_bar_width
    })
    panel.width = action_bar_width
  end

  if state.opened then
    openPanel()
  else
    closePanel()
  end

  screen:connect_signal('toggle_panel', function()
    if state.opened then
      openPanel()
    else
      closePanel()
    end
  end)


  panel:setup {
    layout = wibox.layout.align.vertical,
    nil,
    {
      layout = wibox.layout.align.horizontal,
      main_bar_widget(state, screen),
      info_bar_widget(state, screen),
    },
    bottom_part(state, screen)
  }
  return panel
end

return left_panel

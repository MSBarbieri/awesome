local wibox           = require('wibox')
local dpi             = require('beautiful').xresources.apply_dpi
local main_bar_widget = require('layout.vertical-panel.main_bar')
local info_bar_widget = require('layout.vertical-panel.info_bar')
local bottom_part     = require('layout.vertical-panel.bottom_part')
local utils           = require('utils')

local function position(state, screen)
  local size = dpi(80)
  if state.opened then
    size = dpi(360)
  end

  if state.position == "right" then
    local right = screen.geometry.width - size
    return {
      width = size,
      left = screen.geometry.x,
      right = size,
      x = right
    }
  end
  return {
    width = size,
    left = size,
    right = screen.geometry.x,
    x = screen.geometry.x
  }
end

local function scheme(state, screen)
  if state.position == "right" then
    return {
      layout = wibox.layout.align.horizontal,
      nil,
      info_bar_widget(state, screen),
      main_bar_widget(state, screen),
    }
  else
    return {
      layout = wibox.layout.align.horizontal,
      main_bar_widget(state, screen),
      info_bar_widget(state, screen),
      nil,
    }
  end
end

local vertical_panel = function(state, screen)
  local p = position(state, screen)
  local panel = wibox {
    screen = screen,
    height = screen.geometry.height,
    y = screen.geometry.y,
    width = p.width,
    x = p.x,
    left = p.left,
    right = p.right,
    ontop = true,
    bg = "#22222244",
  }

  panel.enabled = state.enabled
  p = position(state, screen)
  panel.width = p.width
  panel:struts(p)

  screen:connect_signal('toggle_panel', function()
    p = position(state, screen)
    panel.width = p.width
    panel.x = p.x
    panel:struts(p)
  end)


  panel:setup {
    layout = wibox.layout.align.vertical,
    nil,
    scheme(state, screen),
    bottom_part(state, screen)
  }
  return panel
end

return vertical_panel

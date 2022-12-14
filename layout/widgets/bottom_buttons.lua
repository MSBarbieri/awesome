local icons               = require('theme.icons')
local dpi                 = require('beautiful').xresources.apply_dpi
local mat_icon            = require('widget.material.icon')
local wibox               = require('wibox')
local beautiful           = require('beautiful')
local clickable_container = require('widget.material.clickable-container')

local function bottom_buttons(state, screen)
  local function button(name)
    local icon = icons[name]
    if state.area == name then
      icon = icons.selected[name]
    end

    local w_icon =
    {
      size = dpi(40),
      widget = mat_icon(icon),
    }

    local widget = clickable_container(w_icon, function()
      state.area = name
      screen:emit_signal('info_area')
    end)

    screen:connect_signal('info_area', function()
      if state.area == name then
        w_icon.widget:set_icon(icons.selected[name])
      else
        w_icon.widget:set_icon(icons[name])
      end
    end)

    return {
      w_icon,
      widget = widget
    }
  end

  local spotify = button('spotify')
  local twitch = button('twitch')
  local obs = button('obs')

  return {
    widget = wibox.container.margin,
    bg = beautiful.background.hue_800,
    {
      widget = wibox.layout.fixed.horizontal,
      spacing = dpi(15),
      obs,
      spotify,
      twitch
    }
  }
end

return bottom_buttons

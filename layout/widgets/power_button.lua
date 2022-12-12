local awful = require('awful')
local gears = require("gears")
local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi
local mat_icon = require('widget.material.icon')
local icons = require('theme.icons')
local clickable_container = require('widget.material.clickable-container')

local function power_button_widget(_)
  local power_button = wibox.widget {
    {
      icon = icons.power,
      size = dpi(24),
      widget = mat_icon,
    },
    widget = clickable_container
  }
  power_button:buttons(
    gears.table.join(
      awful.button(
        {},
        1,
        nil,
        function()
          exit_screen_show()
        end
      )
    )
  )
  return power_button
end

return power_button_widget

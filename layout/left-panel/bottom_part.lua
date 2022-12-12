local awful               = require('awful')
local gears               = require("gears")
local beautiful           = require('beautiful')
local mat_icon            = require('widget.material.icon')
local icons               = require('theme.icons')
local widgets             = require('layout.widgets')
local clickable_container = require('widget.material.clickable-container')
local dpi                 = require('beautiful').xresources.apply_dpi
local wibox               = require('wibox')

local function bottom_part(state, screen)

  local plus_button = wibox.widget {
    {
      icon = icons.plus,
      size = dpi(24),
      widget = mat_icon
    },
    widget = clickable_container,
  }


  plus_button:buttons(
    gears.table.join(
      awful.button(
        {},
        1,
        nil,
        function()
          state.opened = not state.opened
          screen:emit_signal('toggle_panel')
        end
      )
    )
  )

  return {
    layout = wibox.layout.align.horizontal,
    {
      forced_height = dpi(80),
      forced_width = dpi(80),
      widget = wibox.container.background,
      bg = beautiful.background.hue_800,
      plus_button
    },
    {
      widget = wibox.container.background,
      bg = beautiful.background.hue_800,
      forced_height = dpi(80),
      widgets.bottom_buttons(state, screen)
    },
    nil
  }
end

return bottom_part

local icons = require('theme.icons')
local dpi = require('beautiful').xresources.apply_dpi
local mat_icon = require('widget.material.icon')
local wibox = require('wibox')
local beautiful = require('beautiful')
local clickable_container = require('widget.material.clickable-container')

local function bottom_buttons(screen)
  return {
    widget = wibox.container.margin,
    bg = beautiful.background.hue_800,
    {
      widget = wibox.layout.fixed.horizontal,
      spacing = dpi(15),
      {
        {
          icon = icons.obs,
          size = dpi(40),
          widget = mat_icon,
        },
        widget = clickable_container
      },
      {
        {
          icon = icons.spotify,
          size = dpi(40),
          widget = mat_icon,
        },
        widget = clickable_container
      },
      {
        {
          icon = icons.selected.twitch,
          size = dpi(40),
          widget = mat_icon,
        },
        widget = clickable_container
      }
    }
  }
end

return bottom_buttons

local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require("gears")
local mat_list_item = require('widget.material.list-item')
local mat_icon = require('widget.material.icon')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('theme.icons')

return function(_, panel)
  local search_button =
  wibox.widget {
    wibox.widget {
      icon = icons.search,
      size = dpi(24),
      widget = mat_icon
    },
    wibox.widget {
      text = 'Search Applications',
      font = 'Roboto medium 13',
      widget = wibox.widget.textbox
    },
    clickable = true,
    widget = mat_list_item
  }

  search_button:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        function()
          panel:run_rofi()
        end
      )
    )
  )

  local exit_button =
  wibox.widget {
    wibox.widget {
      icon = icons.logout,
      size = dpi(24),
      widget = mat_icon
    },
    wibox.widget {
      text = 'End work session',
      font = 'Roboto medium 13',
      widget = wibox.widget.textbox
    },
    clickable = true,
    divider = true,
    widget = mat_list_item
  }

  exit_button:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        function()
          panel:toggle()
          _G.exit_screen_show()
        end
      )
    )
  )

  return wibox.widget {
    layout = wibox.layout.align.vertical,
    {
      layout = wibox.layout.fixed.vertical,
      {
        search_button,
        bg = beautiful.background.hue_800,
        widget = wibox.container.background
      },
      wibox.widget {
        orientation = 'horizontal',
        forced_height = 1,
        opacity = 0.08,
        widget = wibox.widget.separator
      },
      require('layout.left-panel.dashboard.quick-settings'),
      require('layout.left-panel.dashboard.hardware-monitor')
    },
    nil,
    {
      layout = wibox.layout.fixed.vertical,
      {
        exit_button,
        bg = gears.create_pattern({
          type = "radial",
          from = { 50, 50, 10 },
          to = { 55, 55, 30 },
          stops = { { 0, "#ff0000" }, { 0.5, "#00ff00" }, { 1, "#0000ff" } }
        }),
        widget = wibox.container.background
      }
    }
  }
end

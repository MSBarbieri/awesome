local gears = require("gears")
local beautiful = require('beautiful')
local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi

local function info_bar(opts, screen)

  local second_menu_color = gears.color.create_pattern({
    type = "linear",
    from = { 0, 0 },
    to = { dpi(7), 0 },
    stops = { { 0, beautiful.background.hue_800 .. "CC" }, { 1, "#00000000" } }
  })

  local text = wibox.widget.textbox(opts.area)

  screen:connect_signal('info_area', function()
    text:set_markup_silently(opts.area)
  end)

  local title = {
    text,
    widget = wibox.container.margin,
    bottom = dpi(20),
  }

  local info_bar_widget = wibox.widget {
    {
      widget = wibox.container.background,
      bg = beautiful.background.hue_800 .. "CC",
      {
        forced_height = dpi(48),
        widget = wibox.container.margin,
        bottom = 1,
        color = "#FFFFFF" .. "22",
        title
        -- TODO: name left panel
      },
    },
    {
      widget = wibox.container.background,
      bg = second_menu_color,
      {
        widget = wibox.container.background,
        -- TODO: fill left panel app content
        nil -- main content
      }
    },
    {
      widget = wibox.container.background,
      bg = second_menu_color,
      {
        widget = wibox.container.background,
      }
    },
    layout = wibox.layout.align.vertical,
  }

  return info_bar_widget
end

return info_bar

local gears = require("gears")
local beautiful = require('beautiful')
local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi
local power_button_widget = require('layout.widgets.power_button')

local TagList = require('widget.tag-list')

local function main_bar(state, screen)
  local shape_top = function(cr, w, h)
    return gears.shape.partially_rounded_rect(cr, w, h, false, false, true, false, 200)
  end
  local shape_middle = function(cr, w, h)
    return gears.shape.partially_rounded_rect(cr, w, h, true, false, false, true, 200)
  end
  local shape_bottom = function(cr, w, h)
    return gears.shape.partially_rounded_rect(cr, w, h, false, true, false, false, 200)
  end

  local middle_body = {
    {
      {
        {
          shape = function(cr, w, h)
            return gears.shape.partially_rounded_rect(cr, w, h, true, false, false, true, 200)
          end,
          widget = wibox.container.background,
          bg = beautiful.background.hue_800,
          {
            widget = wibox.container.margin,
            top = dpi(30),
            bottom = dpi(30),
            TagList(screen),
          }
        },
        widget = wibox.container.margin,
        left = 8,
      },
      bg = beautiful.background.hue_900,
      widget = wibox.container.background,
    },
    bg = beautiful.background.hue_800,
    widget = wibox.container.background,
  }

  if state.position == "right" then
    shape_top = function(cr, w, h)
      return gears.shape.partially_rounded_rect(cr, w, h, false, false, false, true, 200)
    end
    shape_middle = function(cr, w, h)
      return gears.shape.partially_rounded_rect(cr, w, h, false, true, true, false, 200)
    end
    shape_bottom = function(cr, w, h)
      return gears.shape.partially_rounded_rect(cr, w, h, true, false, false, false, 200)
    end
    middle_body = {
      {
        {
          {
            shape = shape_middle,
            widget = wibox.container.background,
            bg = beautiful.background.hue_800,
            {
              widget = wibox.container.margin,
              top = dpi(30),
              bottom = dpi(30),
              TagList(screen),
            }
          },
          widget = wibox.container.margin,
          right = 8,
        },
        bg = beautiful.background.hue_900,
        widget = wibox.container.background,
      },
      bg = beautiful.background.hue_800,
      widget = wibox.container.background,
    }
  end

  return wibox.widget {
    {
      {
        shape = shape_top,
        widget = wibox.container.background,
        bg = beautiful.background.hue_900,
        {
          power_button_widget(),
          widget = wibox.container.margin,
          bottom = dpi(20),
        }
        , -- top icon
      },
      bg = beautiful.background.hue_800,
      widget = wibox.container.background,
    },
    middle_body,
    {
      {
        widget = wibox.container.background,
        bg = beautiful.background.hue_900,
        shape = shape_bottom,
        {
          nil,
          widget = wibox.container.margin,
          top = dpi(100),
        }
        --last part of task menu
      },
      widget = wibox.container.background,
      bg = beautiful.background.hue_800,
    },
    forced_width = dpi(80),
    layout = wibox.layout.align.vertical,
  }
end

return main_bar

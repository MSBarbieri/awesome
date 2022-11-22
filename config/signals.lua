local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local utils = require("utils")

local function setup_signals(_)

  -- Create a wibox for each screen and add it
  awful.screen.connect_for_each_screen(
    function(s)
      -- If wallpaper is a function, call it with the screen
      if beautiful.wallpaper then
        if type(beautiful.wallpaper) == "string" then
          if beautiful.wallpaper:sub(1, #"#") == "#" then
            gears.wallpaper.set(beautiful.wallpaper)
          elseif beautiful.wallpaper:sub(1, #"/") == "/" then
            gears.wallpaper.maximized(beautiful.wallpaper, s)
          end
        else
          beautiful.wallpaper(s)
        end
      end
    end
  )


  -- Signal function to execute when a new client appears.
  awesome.connect_signal(
    'manage',
    function(c)
      -- Set the windows at the slave,
      -- i.e. put it at the end of others instead of setting it master.
      if not awesome.startup then
        awful.client.setslave(c)
      end

      if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
      end
    end
  )

  client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = true })
  end)

  awesome.connect_signal(
    'focus',
    function(c)
      c.border_color = beautiful.border_focus
    end
  )
  awesome.connect_signal(
    'unfocus',
    function(c)
      c.border_color = beautiful.border_normal
    end
  )
end

return setup_signals

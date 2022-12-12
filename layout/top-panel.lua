local awful           = require('awful')
local beautiful       = require('beautiful')
local wibox           = require('wibox')
local gears           = require('gears')
local mat_icon_button = require('widget.material.icon-button')
local mat_icon        = require('widget.material.icon')
local utils           = require('utils')

local dpi = require('beautiful').xresources.apply_dpi

local icons = require('theme.icons')

local add_button = mat_icon_button(mat_icon(icons.plus, dpi(24)))
add_button:buttons(
  gears.table.join(
    awful.button(
      {},
      1,
      nil,
      function()
        awful.spawn(
          awful.screen.focused().selected_tag.defaultApp,
          {
            tag = mouse.screen.selected_tag,
            placement = awful.placement.bottom_right
          }
        )
      end
    )
  )
)

local TopPanel = function(opts, s)
  local window_size = nil

  if opts.opened then
    window_size = dpi(360)
  else
    window_size = dpi(80)
  end

  local panel =
  wibox(
    {
      ontop = true,
      screen = s,
      height = dpi(48),
      width = s.geometry.width - window_size,
      x = s.geometry.x + window_size,
      y = s.geometry.y,
      stretch = false,
      -- opacity = 0,
      bg = beautiful.background.hue_800 .. "CC",
      -- fg = beautiful.fg_normal,
      struts = {
        top = dpi(48)
      }
    }
  )

  panel:struts(
    {
      top = dpi(48)
    }
  )


  panel.enabled = opts.enabled
  screen.connect_signal("menu::toggled", function()
    utils.log("signal", "works")
  end)

  panel:setup {
    layout = wibox.layout.align.horizontal,
    {
      layout = wibox.layout.fixed.horizontal,
      -- Create a taglist widget
      -- TaskList(s),
      -- add_button
    },
    nil,
    {
      layout = wibox.layout.fixed.horizontal,
      -- Layout box
      -- LayoutBox(s)
    }
  }

  return panel
end

return TopPanel

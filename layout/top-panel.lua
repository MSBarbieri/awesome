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

local closed_size = dpi(80)
local opened_size = dpi(360)
local function position(state, screen)
  local size = closed_size
  if state.opened then
    size = opened_size
  end

  if state.position == "right" then
    return {
      width = screen.geometry.width - size,
      x = screen.geometry.x
    }
  end
  return {
    width = screen.geometry.width - size,
    x = screen.geometry.x + size
  }
end

local TopPanel = function(state, screen)
  local p = position(state, screen)
  local panel =
  wibox({
    ontop = true,
    screen = screen,
    height = dpi(48),
    width = p.width,
    x = p.x,
    y = screen.geometry.y,
    stretch = false,
    bg = beautiful.background.hue_800 .. "CC",
    struts = p
  })

  panel:struts({
    top = dpi(48)
  })


  panel.enabled = state.enabled
  screen:connect_signal('toggle_panel', function()
    p = position(state, screen)
    panel.width = p.width
    panel.x = p.x
    panel:struts(p)
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

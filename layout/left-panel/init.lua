local awful = require('awful')
local gears = require("gears")
local beautiful = require('beautiful')
local wibox = require('wibox')
local dpi = require('beautiful').xresources.apply_dpi
local mat_icon = require('widget.material.icon')
local icons = require('theme.icons')
local widgets = require('layout.widgets')
local clickable_container = require('widget.material.clickable-container')
local main_bar_widget = require('layout.left-panel.main_bar')

local left_panel = function(opts, screen)
  local action_bar_width = dpi(80)
  local panel_content_width = dpi(360)

  local panel = wibox {
    screen = screen,
    width = action_bar_width,
    height = screen.geometry.height,
    x = screen.geometry.x,
    y = screen.geometry.y,
    ontop = true,
    bg = "#22222244",
  }

  panel.opened = opts.opened
  panel.enabled = opts.enabled

  local openPanel = function()
    panel:struts({
      left = panel_content_width
    })
    panel.width = panel_content_width
    -- panel:get_children_by_id('panel_content')[1].visible = true
    screen:emit_signal('opened')
  end

  local closePanel = function()
    panel:struts({
      left = action_bar_width
    })
    panel.width = action_bar_width
    -- panel:get_children_by_id('panel_content')[1].visible = false
    screen:emit_signal('closed')
  end

  if opts.opened then
    openPanel()
  else
    closePanel()
  end

  function panel:toggle()
    self.opened = not self.opened
    if self.opened then
      openPanel()
    else
      closePanel()
    end
  end

  local plus_button = wibox.widget {
    {
      icon = icons.plus,
      size = dpi(24),
      widget = mat_icon
    },
    widget = clickable_container
  }


  plus_button:buttons(
    gears.table.join(
      awful.button(
        {},
        1,
        nil,
        function()
          panel:toggle()
        end
      )
    )
  )

  local empty_with_margin = function(comp)
    return {
      comp,
      widget = wibox.container.margin,
      bottom = dpi(20),
    }
  end


  local second_menu_color = gears.color.create_pattern({
    type = "linear",
    from = { 0, 0 },
    to = { dpi(7), 0 },
    stops = { { 0, beautiful.background.hue_800 .. "CC" }, { 1, "#00000000" } }
  })

  local main_bar2 = wibox.widget {
    {
      widget = wibox.container.background,
      bg = beautiful.background.hue_800 .. "CC",
      {
        forced_height = dpi(48),
        widget = wibox.container.margin,
        bottom = 1,
        color = "#FFFFFF" .. "22",
        -- TODO: name left panel
        empty_with_margin({ text = "foo", widget = wibox.widget.textbox }), -- top part
      },
    },
    {
      widget = wibox.container.background,
      bg = second_menu_color,
      {
        widget = wibox.container.background,
        -- TODO: fill left panel app content
        empty_with_margin(nil) -- main content
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

  panel:setup {
    layout = wibox.layout.align.vertical,
    nil,
    {
      layout = wibox.layout.align.horizontal,
      main_bar_widget(opts, screen),
      main_bar2,
    },
    {
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
        widgets.bottom_buttons(opts, screen)
      },
      nil
    }
  }
  return panel
end

return left_panel

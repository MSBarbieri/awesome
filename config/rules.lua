local awful = require('awful')
local gears = require('gears')
local utils = require('utils')
-- Rules
local function setup_rules(_, keys, buttons)
  awful.rules.rules = {
    -- All clients will match this rule.
    {
      rule = {},
      properties = {
        focus = awful.client.focus.filter,
        raise = true,
        keys = keys.client,
        buttons = buttons,
        screen = awful.screen.preferred,
        placement = awful.placement.no_offscreen,
        maximized = false,
        above = false,
        below = false,
        ontop = false,
        sticky = false,
        maximized_horizontal = false,
        maximized_vertical = false
      }
    },
    {
      rule_any = { type = { 'dialog' }, class = { 'Wicd-client.py', 'calendar.google.com' } },
      properties = {
        placement = awful.placement.centered,
        ontop = true,
        floating = true,
        drawBackdrop = false,
        shape = function()
          return function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 8)
          end
        end,
        skip_decoration = true
      }
    }
  }
end

local function generate_tags_apps_rules(tags)
  for index, tag in ipairs(tags) do
    local rule = {
      rule = {
        class = tag.class or tag.defaultApp
      },
      properties = {
        tag = tostring(index),
      }
    }
    utils.merge_table(rule.properties, tag)
    table.insert(awful.rules.rules, rule)
  end
end

return {
  setup = setup_rules,
  tag_rules = generate_tags_apps_rules
}

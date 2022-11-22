local awful = require('awful')

local function setup_client_button(opts)
  local keys = opts.keys

  return awful.util.table.join(
    awful.button(
      {},
      1,
      function(c)
        _G.client.focus = c
        c:raise()
      end
    ),
    awful.button({ keys.mod }, 1, awful.mouse.client.move),
    awful.button({ keys.mod }, 3, awful.mouse.client.resize),
    awful.button(
      { keys.mod },
      4,
      function()
        awful.layout.inc(1)
      end
    ),
    awful.button(
      { keys.mod },
      5,
      function()
        awful.layout.inc(-1)
      end
    )
  )
end

return setup_client_button

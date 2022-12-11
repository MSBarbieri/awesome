local awful = require('awful')
local utils = require("utils")
require('awful.autofocus')

local function setup_client_keys(opts)
  local keys = opts.keys

  return awful.util.table.join(
    awful.key(
      { keys.mod },
      'f',
      function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
      end,
      { description = 'toggle fullscreen', group = 'client' }
    ),
    awful.key(
      { keys.mod },
      'r',
      function(_)
        awful.tag.setmwfact(0.25)
      end,
      { description = 'toggle fullscreen', group = 'client' }
    ),
    awful.key(
      { keys.mod },
      'c',
      function(_)
        awful.tag.setmwfact(0.5)
      end,
      { description = 'toggle fullscreen', group = 'client' }
    ),
    awful.key(
      { keys.mod }, 'comma', function(c)
        c:kill()
      end,
      { description = 'close', group = 'client' }
    )
  )
end

return setup_client_keys

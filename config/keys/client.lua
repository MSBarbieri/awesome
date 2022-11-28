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
        utils.log("client fullscreen", tostring(not c.fullscreen))
      end,
      { description = 'toggle fullscreen', group = 'client' }
    ),
    awful.key(
      { keys.mod },
      'r',
      function(c)
        awful.tag.setmwfact(0.25)
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

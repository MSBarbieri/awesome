local awful = require('awful')

local function client_layout_mode(opts)
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
      'm',
      function()
        client.focus.floating = not client.focus.floating
      end,
      { description = 'focus next by index', group = 'client' }
    )
  )
end

local function client_geo(opts)
  local keys = opts.keys

  return awful.util.table.join(
    awful.key(
      { keys.mod },
      'h',
      function()
        awful.client.focus.bydirection("left")
      end,
      { description = 'focus previous by index', group = 'client' }
    ),
    awful.key(
      { keys.mod },
      'l',
      function()
        awful.client.focus.bydirection("right")
      end,
      { description = 'focus next by index', group = 'client' }
    ),
    awful.key(
      { keys.mod },
      'j',
      function()
        awful.client.focus.bydirection("down")
      end,
      { description = 'focus previous by index', group = 'client' }
    ),
    awful.key(
      { keys.mod },
      'k',
      function()
        awful.client.focus.bydirection("up")
      end,
      { description = 'focus previous by index', group = 'client' }
    ),
    awful.key(
      { keys.mod, keys.sft },
      'h',
      function()
        awful.client.swap.bydirection('left', c)
      end,
      { description = 'increase the number of master clients', group = 'layout' }
    ),
    awful.key(
      { keys.mod, keys.sft },
      'l',
      function()
        awful.client.swap.bydirection('right', c)
      end,
      { description = 'decrease the number of master clients', group = 'layout' }
    ),
    awful.key(
      { keys.mod, keys.sft },
      'j',
      function()
        awful.client.swap.bydirection('down', c)
      end,
      { description = 'move client down', group = 'layout' }
    ),
    awful.key(
      { keys.mod, keys.sft },
      'k',
      function()
        awful.client.swap.bydirection('up', c)
      end,
      { description = 'move client up', group = 'layout' }
    ),
    awful.key(
      { keys.mod, keys.ctrl },
      'h',
      function()
        awful.tag.incmwfact(-0.01)
      end,
      { description = 'decrease master width factor', group = 'client' }
    ),
    awful.key(
      { keys.mod, keys.ctrl },
      'l',
      function()
        awful.tag.incmwfact(0.01)
      end,
      { description = 'increase master width factor', group = 'client' }
    ), awful.key(
      { keys.mod, keys.ctrl },
      'k',
      function()
        awful.tag.incmwfact(-0.01)
      end,
      { description = 'decrease master width factor', group = 'client' }
    ),
    awful.key(
      { keys.mod, keys.ctrl },
      'j',
      function()
        awful.tag.incmwfact(0.01)
      end,
      { description = 'increase master width factor', group = 'client' }
    ),
    awful.key(
      { keys.mod },
      'r',
      function(_)
        awful.tag.setmwfact(0.25)
      end,
      { description = '1920 size in tiled mode', group = 'client' }
    ),
    awful.key(
      { keys.mod },
      'c',
      function(_)
        awful.tag.setmwfact(0.5)
      end,
      { description = 'middle sized client in tiled mode', group = 'client' }
    )
  )
end

local function setup_client_keys(opts)
  local keys = opts.keys

  return awful.util.table.join(
  -- Default client focus
    client_geo(opts),
    client_layout_mode(opts),
    awful.key(
      { keys.mod }, 'comma', function(c)
        c:kill()
      end,
      { description = 'close client', group = 'client' }
    ),
    awful.key({ keys.mod },
      'u',
      awful.client.urgent.jumpto,
      {
        description = 'jump to urgent client',
        group = 'client'
      }),
    awful.key(
      { keys.mod },
      'Tab',
      function()
        awful.client.focus.history.previous()
        if client.focus then
          client.focus:raise()
        end
      end,
      { description = 'go back', group = 'client' }
    )
  )
end

return setup_client_keys

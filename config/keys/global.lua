local awful = require('awful')
require('awful.autofocus')
local hotkeys_popup = require('awful.hotkeys_popup').widget
local layout        = require('layout')

local function execute_apps(opts)
  local keys = opts.keys

  return awful.util.table.join(
    awful.key(
      { keys.mod }, 'Return', function()
        awful.spawn(opts.apps.terminal)
      end,
      { description = 'open a terminal', group = 'launcher' }
    ),
    awful.key(
      { keys.mod }, 'e', function()
        awful.spawn(opts.apps.editor)
      end,
      { description = 'open a editor', group = 'launcher' }
    ),
    awful.key({ keys.mod }, 'space', function()
      awful.util.spawn_with_shell(opts.apps.launcher)
    end, { description = 'rofi rofi', group = 'launcher' }),
    awful.key({ keys.mod }, 'b', function()
      awful.util.spawn(opts.apps.browser)
    end, { description = 'open browser', group = 'launcher' }),
    awful.key(
      {},
      'Print',
      function()
        awful.util.spawn_with_shell('flameshot gui')
      end
    )
  )
end

local function hotkeys(_)
  return awful.util.table.join(
    awful.key(
      {},
      'XF86MonBrightnessUp',
      function()
        awful.spawn('xbacklight -inc 10')
      end,
      { description = '+10%', group = 'hotkeys' }
    ),
    awful.key(
      {},
      'XF86MonBrightnessDown',
      function()
        awful.spawn('xbacklight -dec 10')
      end,
      { description = '-10%', group = 'hotkeys' }
    ),
    -- ALSA volume control
    awful.key(
      {},
      'XF86AudioRaiseVolume',
      function()
        awful.spawn('pactl set-sink-volume @DEFAULT_SINK@ +10%')
      end,
      { description = 'volume up', group = 'hotkeys' }
    ),
    awful.key(
      {},
      'XF86AudioLowerVolume',
      function()
        awful.spawn('pactl set-sink-volume @DEFAULT_SINK@ -10%')
      end,
      { description = 'volume down', group = 'hotkeys' }
    ),
    awful.key(
      {},
      'XF86AudioMute',
      function()
        awful.spawn('pactl set-sink-mute @DEFAULT_SINK@ toggle')
      end,
      { description = 'toggle mute', group = 'hotkeys' }
    ),
    awful.key(
      {},
      'XF86AudioNext',
      function()
        awful.spawn('playerctl next -p spotify')
      end,
      { description = 'next music', group = 'audio' }
    ),
    awful.key(
      {},
      'XF86AudioPrev',
      function()
        awful.spawn('playerctl previous -p spotify')
      end,
      { description = 'prev music', group = 'audio' }
    ),
    awful.key(
      {},
      'XF86AudioPlay',
      function()
        awful.spawn('playerctl play-pause -p spotify')
      end,
      { description = 'toggle music', group = 'audio' }
    ),
    awful.key(
      {},
      'XF86PowerDown',
      function()
        --
      end,
      { description = 'toggle mute', group = 'hotkeys' }
    ),
    awful.key(
      {},
      'XF86PowerOff',
      function()
        Exit_screen_show()
      end,
      { description = 'toggle mute', group = 'hotkeys' }
    )
  )
end

local setup_keys = function(opts)
  local keys = opts.keys

  local globalKeys =
  awful.util.table.join(
    execute_apps(opts),
    hotkeys(opts),
    -- Hotkeys
    awful.key({ keys.mod }, 'F1', function()
      hotkeys_popup.show_help(nil, awful.screen.focused())
    end,
      { description = 'show help', group = 'awesome' }),
    awful.key({ keys.mod, keys.ctrl }, 'r', function()
      awesome.restart()
    end, { description = 'reload awesome', group = 'awesome' }),
    awful.key({ keys.mod, keys.ctrl }, 'q', awesome.quit, { description = 'quit awesome', group = 'awesome' }),
    -- Tag browsing
    awful.key({ keys.mod }, 'w', awful.tag.viewprev, { description = 'view previous', group = 'tag' }),
    awful.key({ keys.mod }, 's', awful.tag.viewnext, { description = 'view next', group = 'tag' }),
    awful.key(
      { keys.mod, keys.sft },
      't',
      function()
        layout.toggle_info_panel()
      end,
      { description = 'toggle panel', group = 'awesome' }
    ),
    awful.key(
      { keys.mod },
      't',
      function()
        layout.toggle()
      end,
      { description = 'toggle info panel', group = 'awesome' }
    ),
    awful.key(
      { keys.mod },
      'F11',
      function()
        awful.spawn('setxkbmap -layout my_us -variant dvp -option "caps:swapescape"')
      end,
      { description = 'change keyboard layout', group = 'awesome' }
    ),
    awful.key(
      { keys.mod },
      'F12',
      function()
        awful.spawn('setxkbmap -layout my_us -option "caps:swapescape"')
      end,
      { description = 'change keyboard layout', group = 'awesome' }
    ),
    -- Layout
    awful.key(
      { keys.mod, keys.sft },
      'Tab',
      function()
        local len = 0
        local max = 0
        local tag = awful.screen.focused().selected_tag

        for i, l in pairs(awful.layout.layouts) do
          if l == tag.layout then
            len = i
          end
          max = i
        end
        if len == max then
          tag.layout = tag.layouts[1]
        else
          tag.layout = tag.layouts[len + 1]
        end
      end,
      { description = 'change tag layout', group = 'layout' }
    )
  )

  -- Bind all key numbers to tags.
  -- Be careful: we use keycodes to make it works on any keyboard layout.
  -- This should map on the top row of your keyboard, usually 1 to 9.
  for i = 1, 10 do
    -- Hack to only show tags 1 and 9 in the shortcut window (keys.mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 10 then
      descr_view = { description = 'view tag #', group = 'tag' }
      descr_toggle = { description = 'toggle tag #', group = 'tag' }
      descr_move = { description = 'move focused client to tag #', group = 'tag' }
      descr_toggle_focus = { description = 'toggle focused client on tag #', group = 'tag' }
    end
    globalKeys = awful.util.table.join(
      globalKeys,
      -- View tag only.
      awful.key(
        { keys.mod },
        '#' .. i + 9,
        function()
          local screen = awful.screen.focused()
          local tag = screen.tags[i]
          if tag then
            tag:view_only()
          end
        end,
        descr_view
      ),
      -- Toggle tag display.
      awful.key(
        { keys.mod, keys.ctrl },
        '#' .. i + 9,
        function()
          local screen = awful.screen.focused()
          local tag = screen.tags[i]
          if tag then
            awful.tag.viewtoggle(tag)
          end
        end,
        descr_toggle
      ),
      -- Move client to tag.
      awful.key(
        { keys.mod, keys.sft },
        '#' .. i + 9,
        function()
          if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then
              client.focus:move_to_tag(tag)
            end
          end
        end,
        descr_move
      ),
      -- Toggle tag on focused client.
      awful.key(
        { keys.mod, keys.ctrl, keys.sft },
        '#' .. i + 9,
        function()
          if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then
              client.focus:toggle_tag(tag)
            end
          end
        end,
        descr_toggle_focus
      )
    )
  end

  return globalKeys
end

return setup_keys

local awful = require('awful')

local function setup_signals(callback)
  -- Hide bars when app go fullscreen
  tag.connect_signal(
    'property::selected',
    function()
      callback("selected")
    end
  )

  client.connect_signal(
    'property::fullscreen',
    function(c)
      c.first_tag.fullscreenMode = c.fullscreen
      callback("fullscreen")
    end
  )

  client.connect_signal(
    'manage',
    function(c)
      if c.class == nil then
        c.minimized = true
        c:connect_signal("property::class", function()
          c.minimized = false
          awful.rules.apply(c)
        end)
      end
    end
  )

  client.connect_signal(
    'unmanage',
    function(c)
      if c.fullscreen then
        c.screen.selected_tag.fullscreenMode = false
        callback("unmanage")
      end
    end
  )
end

local function screen_signals(screen, callback)
  screen:connect_signal('toggle_layout', function()
    callback()
  end)
end

return {
  setup_signals = setup_signals,
  screen_signals = screen_signals
}

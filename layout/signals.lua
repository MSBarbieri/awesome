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
    function(_)
      callback("manage")
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
  local dpi = require('beautiful').xresources.apply_dpi

  screen:connect_signal('toggle_panel', function(_, opened)
    local size = dpi(80)
    if opened then
      size = dpi(360)
    end

    screen.top_panel.width = screen.geometry.width - size
    screen.top_panel.x = screen.geometry.x + size
  end)

  screen:connect_signal('toggle_layout', function()
    callback()
  end)
end

return {
  setup_signals = setup_signals,
  screen_signals = screen_signals
}

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

local function screen_signals(s, callback)
  local dpi = require('beautiful').xresources.apply_dpi

  s:connect_signal('opened', function()
    s.top_panel.width = s.geometry.width - dpi(360)
    s.top_panel.x = s.geometry.x + dpi(360)
  end)
  s:connect_signal('closed', function()
    s.top_panel.width = s.geometry.width - dpi(80)
    s.top_panel.x = s.geometry.x + dpi(80)
  end)

  s:connect_signal('toggle_layout', function()
    s.top_panel.enabled = not s.top_panel.enabled
    s.left_panel.enabled = not s.left_panel.enabled
    callback()
  end)
end

return {
  setup_signals = setup_signals,
  screen_signals = screen_signals
}

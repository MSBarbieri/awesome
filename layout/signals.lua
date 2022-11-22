local utils = require "utils"
local dpi = require('beautiful').xresources.apply_dpi
local function setup_signals(callback)
  -- Hide bars when app go fullscreen
  _G.tag.connect_signal(
    'property::selected',
    function(t)
      callback("selected")
    end
  )

  _G.client.connect_signal(
    'property::fullscreen',
    function(c)
      c.first_tag.fullscreenMode = c.fullscreen
      callback("fullscreen")
    end
  )

  _G.client.connect_signal(
    'manage',
    function(c)
      callback("manage")
    end
  )

  _G.client.connect_signal(
    'unmanage',
    function(c)
      if c.fullscreen then
        c.screen.selected_tag.fullscreenMode = false
        callback("unmanage")
      end
    end
  )
end

return setup_signals

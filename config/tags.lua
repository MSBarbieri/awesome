local awful = require('awful')

local function setup_tags(opts)
  local tags = {
    {
      icon       = "brave",
      type       = 'browser',
      class      = "Brave",
      defaultApp = opts.apps.browser,
      screen     = 1
    },
    {
      icon       = "code",
      type       = 'code',
      class      = "kitty",
      defaultApp = opts.apps.editor,
      screen     = 1
    },
    {
      icon       = "rss",
      type       = 'fluent-reader',
      class      = "fluent-reader",
      defaultApp = '',
      screen     = 1
    },
    {
      icon       = "folder",
      type       = 'files',
      class      = "Org.gnome.Nautilus",
      defaultApp = 'nautilus',
      screen     = 1
    },
    {
      icon       = "postman",
      type       = 'debug',
      defaultApp = "postman",
      class      = "Postman",
      screen     = 1
    },
    {
      icon       = "slack",
      type       = 'social',
      defaultApp = "slack",
      screen     = 1
    },
    {
      icon = "discord",
      type = 'social',
      defaultApp = "discord",
      screen = 1
    },
    {
      icon       = "spotify",
      type       = 'music',
      defaultApp = "spotify",
      screen     = 1
    },
    {
      icon       = "obs",
      type       = 'obs',
      defaultApp = "obs",
      screen     = 1
    },
    {
      icon       = "notion",
      type       = 'notion',
      defaultApp = "notion-snap",
      screen     = 1
    },
  }

  awful.layout.layouts = {
    awful.layout.suit.max,
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.floating,
  }

  awful.screen.connect_for_each_screen(
    function(s)
      for i, tag in pairs(tags) do
        awful.tag.add(
          i,
          {
            icon = tag.icon,
            selected_icon = tag.selected_icon or tag.icon,
            icon_only = false,
            layout = tag.layout or awful.layout.suit.max,
            gap_single_client = false,
            gap = 0,
            screen = s,
            defaultApp = tag.defaultApp,
            selected = i == 1
          }
        )
      end
    end
  )

  tag.connect_signal(
    'property::layout',
    function(t)
      local currentLayout = awful.tag.getproperty(t, 'layout')
      if (currentLayout == awful.layout.suit.max) then
        t.gap = 0
      else
        t.gap = 0
      end
    end
  )

  return tags
end

return setup_tags

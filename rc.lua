require("awful.autofocus")
local awful = require("awful")
require("error_handler")

require('theme').setup({
  wallpaper = "/home/matheus-barbieri/Pictures/wallpapers/wallpaper"
  -- wallpaper = "#555555"
})

require('layout').setup({
  enabled = true,
  opened = false,
  area = "obs",
  position = "right"
})

require("config").setup({
  apps = {
    browser = 'brave',
    launcher = os.getenv('HOME') .. "/.config/rofi/launchers/type-4/launcher.sh",
    editor = 'kitty tmux-sessionizer ' .. os.getenv('HOME')
  },
})

require("module").setup({
  execute = {
    -- { cmd = 'discord', type = "app", opts = { tag = awful.screen.focused().tags[7] } },
    { cmd = 'pidgin', type = "app", opts = { tag = awful.screen.focused().tags[6] } },
    -- { cmd = 'spotify', type = "app", opts = { tag = awful.screen.focused().tags[8] } },
    { cmd = 'picom', type = "app" },
    { cmd = function()
      return require('config').settings.apps.browser
    end, type = "app" },
    -- { cmd = function()
    --   return require('config').settings.apps.editor
    -- end, type = "script", opts = { sleep = 1 } },
    -- { cmd = 'while [ -n "$(playerctl play -p spotify 2>&1 >/dev/null)" ]; do sleep 1; done;glava -d',
    --   type = "script", opts = { sleep = 1 } },
  }
})

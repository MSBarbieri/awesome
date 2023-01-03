require("awful.autofocus")
require("error_handler")
local utils = require('utils')

require('theme').setup({
  wallpaper = "/home/matheus-barbieri/Pictures/wallpapers/wallpaper"
  -- wallpaper = "#555555"
})

require('layout').setup({
  enabled = false,
  opened = false,
  area = "twitch",
})

require("module").setup({
  startup_scripts = {
    { cmd = 'picom --config=' .. os.getenv('HOME') .. '/.config/picom/picom.conf' },
    { cmd = 'spotify' },
    { cmd = 'discord' },
    { cmd = 'pidgin' },
  },
  lazy_scripts = {

    { cmd = 'glava -d' },
    { cmd = function()
      return require('config').settings.apps.editor
    end },
    { cmd = 'while [ -n "$(playerctl play -p spotify 2>&1 >/dev/null)" ]; do sleep 1; done' },
  }
})

require("config").setup({
  apps = {
    browser = 'brave',
    launcher = os.getenv('HOME') .. "/.config/rofi/launchers/type-4/launcher.sh",
    editor = 'kitty tmux'
  },
})

require("awful.autofocus")
require("error_handler")

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
    { cmd = 'picom --config=$HOME/.config/picom/picom.conf --experimental-backends' },
    { cmd = 'spotify' },
    { cmd = 'discord' },
    { cmd = 'fluent_reader' },
  },
  lazy_scripts = {
    { cmd = os.getenv('HOME') .. '/.local/scripts/start_animated_background' },
    { cmd = function()
      return require('config').settings.apps.editor
    end },
    -- { cmd = 'while [ -n "$(playerctl play -p spotify 2>&1 >/dev/null)" ]; do sleep 1; done' },
  }
})

require("config").setup({
  apps = {
    browser = 'brave-browser',
    launcher = os.getenv('HOME') .. "/.config/rofi/launchers/type-4/launcher.sh",
    editor = 'kitty ' ..
        os.getenv('HOME') .. '/.local/bin/tmux-sessionizer ' ..
        os.getenv('HOME'),
  },
})

require("awful.autofocus")
require("error_handler")

require('theme').setup({
  wallpaper = "/home/matheus-barbieri/Pictures/wallpapers/wallpaper"
  -- wallpaper = "#555555"
})

require('layout').setup({
  enabled = true,
  opened = false,
  area = "spotify",
})

require("module").setup({
  startup_scripts = {
    { cmd = 'picom --config=$HOME/.config/picom/picom.conf --experimental-backends' },
    { cmd = 'spotify' },
  },
  lazy_scripts = {
    { cmd = "kitty" },
    -- { cmd = 'while [ -n "$(playerctl play -p spotify 2>&1 >/dev/null)" ]; do sleep 1; done' },
    { cmd = os.getenv('HOME') .. '/.local/scripts/start_animated_background' }
  }
})

require("config").setup({
  apps = {
    browser = 'brave-browser',
    launcher = os.getenv('HOME') .. "/.config/rofi/launchers/type-4/launcher.sh"
  },
})

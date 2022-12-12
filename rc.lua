require("awful.autofocus")
require("error_handler")

require('theme').setup({
  wallpaper = "/home/matheus-barbieri/Pictures/wallpapers/wallpaper"
  -- wallpaper = "#080808"
})

require('layout').setup({
  enabled = true,
  opened = true,
  area = "spotify",
})

local awful = require('awful')
require("module").setup({
  -- apps = {
  --   lock = nil,
  -- },
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
    --   terminal = 'kitty',
    --   browser = 'brave',
  },
  -- keys = {
  --   mod = 'Mod4',
  --   alt = 'Mod1',
  --   ctrl = 'Control',
  --   sft = 'Shift',
  -- }
})

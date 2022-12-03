require("awful.autofocus")
require("error_handler")

require('theme').setup({
  wallpaper = "/home/matheus-barbieri/Pictures/wallpapers/wallpaper"
  -- wallpaper = "#080808"
})

require('layout').setup({
  enabled = false,
  opened = false,
  -- area = "twitch",
})

require("module").setup({
  -- apps = {
  --   lock = nil,
  -- },
  startup_scripts = {
    { cmd = 'picom --config=$HOME/.config/picom/picom.conf --experimental-backends' },
    { cmd = 'spotify' },
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

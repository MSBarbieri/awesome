require("awful.autofocus")
require("error_handler")

require('theme').setup({
  wallpaper = "/home/matheus-barbieri/Pictures/wallpapers/wallpaper"
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
    --   'picom --config=$HOME/.config/picom/picom.conf --experimental-backends',
    -- 'blueberry-tray'
    -- '/usr/local/bin/emacs --daemon'
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

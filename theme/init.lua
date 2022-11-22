local utils     = require("utils")
local beautiful = require("beautiful")
local gears     = require("gears")
local dpi       = require('beautiful').xresources.apply_dpi

local setup_theme = require("theme.theme")

local M = {};

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

local default = {
  wallpaper = "/home/matheus-barbieri/Pictures/wallpapers/wallpaper",
}

M.setup = function(opts)
  opts = opts or {}
  opts = utils.merge_table(default, opts)
  local theme = setup_theme(opts)
  beautiful.init(theme)

  screen.connect_signal("property::geometry", set_wallpaper)
end

return M

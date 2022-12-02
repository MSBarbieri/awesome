local filesystem = require('gears.filesystem')
local mat_colors = require('theme.colors')
local gears      = require("gears")
local dpi        = require('beautiful').xresources.apply_dpi

local function setup_theme(opts)
  local theme = {}
  local theme_dir = filesystem.get_configuration_dir() .. 'theme'

  theme.icons = theme_dir .. '/icons/'
  theme.font = 'Roboto medium 10'

  theme.primary = mat_colors.indigo
  theme.primary.hue_500 = '#003f6b'
  -- Accent
  theme.accent = mat_colors.pink

  -- Background
  theme.background = mat_colors.blue_grey
  theme.background.hue_800 = '#252931'
  theme.background.hue_900 = '#3F4B5044'

  -- Primary
  theme.primary = mat_colors.blue_grey
  theme.accent = mat_colors.pink

  theme.background = mat_colors.blue_grey
  theme.background.hue_800 = '#242D31'
  theme.background.hue_900 = '#3F4B5044'

  theme.dir = os.getenv('HOME') .. '/.config/awesome/theme'
  --theme.dir             = os.getenv("HOME") .. "/code/awesome-pro/themes/pro-dark"
  theme.icons = theme.dir .. '/icons/'
  --theme.wallpaper = theme.dir .. '/wallpapers/pro-dark-shadow.png'
  theme.wallpaper = opts.wallpaper or '#e0e0e0'
  theme.font = 'Roboto medium 10'
  theme.title_font = 'Roboto medium 14'

  theme.fg_normal = '#ffffffde'
  theme.fg_focus = '#e4e4e4'
  theme.fg_urgent = '#CC9393'
  theme.bat_fg_critical = '#232323'

  theme.bg_normal = theme.background.hue_800
  theme.bg_focus = '#5a5a5a'
  theme.bg_urgent = '#3F3F3F'
  theme.bg_systray = theme.background.hue_800


  -- Menu
  theme.menu_height = dpi(16)
  theme.menu_width = dpi(160)

  -- Tooltips
  theme.tooltip_bg = '#232323'
  --theme.tooltip_border_color = '#232323'
  theme.tooltip_border_width = 0
  theme.tooltip_shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, dpi(6))
  end

  -- Layout
  theme.layout_max = theme.icons .. 'layouts/arrow-expand-all.png'
  theme.layout_tile = theme.icons .. 'layouts/view-quilt.png'

  -- Taglist
  theme.taglist_bg_empty = theme.background.hue_800
  theme.taglist_bg_occupied = theme.background.hue_800
  theme.taglist_bg_urgent =
  'linear:0,0:' ..
      dpi(48) ..
      ',0:0,' ..
      theme.accent.hue_500 ..
      ':0.08,' .. theme.accent.hue_500 .. ':0.08,' .. theme.background.hue_800 .. ':1,' .. theme.background.hue_800
  theme.taglist_bg_focus =
  'linear:0,0:' ..
      dpi(48) ..
      ',0:0,' ..
      theme.primary.hue_500 ..
      ':0.08,' .. theme.primary.hue_500 .. ':0.08,' .. theme.background.hue_800 .. ':1,' .. theme.background.hue_800

  -- Tasklist
  theme.tasklist_font = 'Roboto medium 11'
  theme.tasklist_bg_normal = theme.background.hue_800
  theme.tasklist_bg_focus =
  'linear:0,0:0,' ..
      dpi(48) ..
      ':0,' ..
      theme.background.hue_800 ..
      ':0.95,' .. theme.background.hue_800 .. ':0.95,' .. theme.fg_normal .. ':1,' .. theme.fg_normal
  theme.tasklist_bg_urgent = theme.primary.hue_800
  theme.tasklist_fg_focus = '#DDDDDD'
  theme.tasklist_fg_urgent = theme.fg_normal
  theme.tasklist_fg_normal = '#AAAAAA'
  theme.icon_theme = 'Papirus-Dark'


  -- Borders
  theme.border_width = opts.border_width or dpi(2)
  theme.border_normal = theme.background.hue_800
  theme.border_focus = '#222222'

  theme.notification_border_color = '#81A1C1FF'
  theme.notification_bg = "#81A1C144"

  return theme
end

return setup_theme

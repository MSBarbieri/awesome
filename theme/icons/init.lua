local dir = os.getenv('HOME') .. '/.config/awesome/theme/icons'

return {
  --tags
  chrome = dir .. '/google-chrome.svg',
  code = dir .. '/code-braces.svg',
  social = dir .. '/forum.svg',
  folder = dir .. '/folder.svg',
  music = dir .. '/music.svg',
  game = dir .. '/google-controller.svg',
  lab = dir .. '/flask.svg',
  --others
  menu = dir .. '/menu.svg',
  close = dir .. '/close.svg',
  logout = dir .. '/logout.svg',
  sleep = dir .. '/power-sleep.svg',
  power = dir .. '/power.svg',
  lock = dir .. '/lock.svg',
  restart = dir .. '/restart.svg',
  search = dir .. '/magnify.svg',
  volume = dir .. '/volume-high.svg',
  brightness = dir .. '/brightness-7.svg',
  chart = dir .. '/chart-areaspline.svg',
  memory = dir .. '/memory.svg',
  harddisk = dir .. '/harddisk.svg',
  thermometer = dir .. '/thermometer.svg',
  plus = dir .. '/plus.svg',


  rss = dir .. '/rss.svg',
  brave = dir .. '/brave.svg',
  twitch = dir .. '/twitch.svg',
  spotify = dir .. '/spotify.svg',
  obs = dir .. '/obs.svg',

  notion = dir .. '/notion.svg',
  slack = dir .. '/slack.svg',
  discord = dir .. '/discord.svg',
  postman = dir .. '/postman.svg',

  selected = {
    code = dir .. '/selected' .. '/code-braces.svg',
    lab = dir .. '/selected' .. '/flask.svg',
    folder = dir .. '/selected' .. '/folder.svg',

    brave = dir .. '/selected' .. '/brave.svg',
    twitch = dir .. '/selected' .. '/twitch.svg',
    spotify = dir .. '/selected' .. '/spotify.svg',
    obs = dir .. '/selected' .. '/obs.svg',

    notion = dir .. '/selected' .. '/notion.svg',
    rss = dir .. '/selected' .. '/rss.svg',
    slack = dir .. '/selected' .. '/slack.svg',
    discord = dir .. '/selected' .. '/discord.svg',
    postman = dir .. '/selected' .. '/postman.svg',
  }
}

-- MODULE AUTO-START
-- Run all the apps listed in configuration/apps.lua as run_on_start_up only once when awesome start

local awful = require('awful')

local function run_auto_start(opts)
  local function run_once(script)
    local cmd = script.cmd
    if type(cmd) == 'function' then
      cmd = cmd()
    end

    local findme = cmd
    local firstspace = cmd:find(' ')
    if firstspace then
      findme = cmd:sub(0, firstspace - 1)
    end

    local exec = string.format('pgrep -u $USER -x %s > /dev/null || (%s)', findme, cmd)
    awful.spawn.easy_async_with_shell(exec)
  end

  for _, app in ipairs(opts.startup_scripts) do
    run_once(app)
  end

  awesome.connect_signal('loaded', function()
    for _, app in ipairs(opts.lazy_scripts) do
      run_once(app)
    end
  end)
end

return run_auto_start

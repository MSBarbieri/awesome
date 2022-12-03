-- MODULE AUTO-START
-- Run all the apps listed in configuration/apps.lua as run_on_start_up only once when awesome start

local awful = require('awful')

local function run_auto_start(opts)
  local function run_once(script)
    if script.opts then
      awful.spawn(script.cmd, script.opts)
    else
      local cmd = script.cmd
      local findme = cmd
      local firstspace = cmd:find(' ')
      if firstspace then
        findme = cmd:sub(0, firstspace - 1)
      end

      local exec = string.format('pgrep -u $USER -x %s > /dev/null || (%s)', findme, cmd)
      awful.spawn.with_shell(exec)
    end
  end

  for _, app in ipairs(opts.startup_scripts) do
    run_once(app)
  end
end

return run_auto_start

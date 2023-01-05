-- MODULE AUTO-START
-- Run all the apps listed in configuration/apps.lua as run_on_start_up only once when awesome start
local awful = require('awful')
local utils = require('utils')

local function run_auto_start(opts)
  local function run_once(script)
    local cmd = script.cmd
    if type(cmd) == 'function' then
      cmd = cmd()
    end

    if script.type == 'app' then
      awful.spawn(cmd, script.opts)
    else
      if script.opts and script.opts.restart then
        awful.spawn.with_shell(utils.restart(cmd))
      end
      local exec = utils.filter_command(cmd)
      if script.opts and script.opts.sleep then
        exec = tostring(script.opts.sleep) .. "; " .. exec
      end
      awful.spawn.with_shell(exec)
    end
  end

  for _, commands in ipairs(opts.execute) do
    run_once(commands)
  end
end

return run_auto_start

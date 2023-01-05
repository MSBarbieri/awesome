local awful = require('awful')
local M = {}
M.log = function(title, txt)
  local naughty = require("naughty")
  naughty.notify(
    {
      title = 'log: ' .. title,
      text = txt
    }
  )
end

M.merge_table = function(t1, t2)
  for k, v in pairs(t2) do
    if type(v) == "table" then
      if type(t1[k] or false) == "table" then
        M.merge_table(t1[k] or {}, t2[k] or {})
      else
        t1[k] = v
      end
    else
      t1[k] = v
    end
  end
  return t1
end

M.filter_command = function(cmd)
  local findme = cmd
  local firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace - 1)
  end
  return string.format("pgrep -u $USER %s > /dev/null || (%s)", findme, cmd)
end

M.restart = function(cmd)
  local findme = cmd
  local firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace - 1)
  end

  return string.format(
    "for pid in $(ps -ef | awk '/%s/ {print $2}'); do kill -9 $pid; done;",
    findme)
end

return M

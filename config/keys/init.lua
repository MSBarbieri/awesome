local global_setup = require("config.keys.global")
local client_setup = require("config.keys.client")

local function setup_keys(opts)
  return {
    global = global_setup(opts),
    client = client_setup(opts)
  }
end

return setup_keys

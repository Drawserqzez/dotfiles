local dap = require('dap')
local commonStuff = require('algot.config.heirline.bareBones')
local utils = require('heirline.utils')

local DapStatus = {
    condition = function()
        local session = dap.session()
        return session ~= nil
    end,
    provider = function()
        return " " .. dap.status()
    end,
    hl = "Debug"
}

return {
    condition = DapStatus.condition,
    utils.surround(commonStuff.roundedSurround, "bright_bg", { DapStatus })
}

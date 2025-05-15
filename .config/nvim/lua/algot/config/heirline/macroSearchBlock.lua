local conditions = require('heirline.conditions')
local utils = require('heirline.utils')
local commonStuff = require('algot.config.heirline.bareBones')

local SearchCount = require('algot.config.heirline.searchCount')
local MacroRec = require('algot.config.heirline.macroRec')

local BigBlock = {
    condition = function()
        return SearchCount.condition() or MacroRec.condition()
    end,
    utils.surround(commonStuff.roundedSurround, "bright_bg", {
        SearchCount,
        MacroRec,
    })
}

return BigBlock

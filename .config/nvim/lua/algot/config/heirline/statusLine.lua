local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

local commonStuff = require('algot.config.heirline.bareBones')
local ViMode = require('algot.config.heirline.viMode')
local FileNameEtc = require('algot.config.heirline.fileName')
local Ruler = require('algot.config.heirline.rulerStuff')
local LspStatus = require('algot.config.heirline.lspStatus')
local GitBlock = require('algot.config.heirline.gitStatus')
local MacroSearchBlock = require('algot.config.heirline.macroSearchBlock')

local StatusLine = {
    utils.surround(commonStuff.roundedSurround, "bright_bg", { ViMode }),
    MacroSearchBlock,
    FileNameEtc,
    commonStuff.space,
    GitBlock,
    commonStuff.align,
    LspStatus,
    commonStuff.space,
    utils.surround(commonStuff.roundedSurround, "bright_bg", { Ruler })
}

return StatusLine

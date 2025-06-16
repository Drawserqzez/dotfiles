local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

local commonStuff = require('algot.config.heirline.bareBones')
local ViMode = require('algot.config.heirline.viMode')
local FileNameEtc = require('algot.config.heirline.fileName')
local Ruler = require('algot.config.heirline.rulerStuff')
local LspStatus = require('algot.config.heirline.lspStatus')
local DapStatus = require('algot.config.heirline.dapStatus')
local GitBlock = require('algot.config.heirline.gitStatus')
local MacroSearchBlock = require('algot.config.heirline.macroSearchBlock')
local ShowCmd = require('algot.config.heirline.showCmd')
local HelpFileName = require('algot.config.heirline.helpFileName')
local Diagnostics = require('algot.config.heirline.diagnostics')

local StatusLine = {
    utils.surround(commonStuff.roundedSurround, "bright_bg", { ViMode, commonStuff.space, ShowCmd }),
    MacroSearchBlock,
    FileNameEtc,
    commonStuff.space,
    GitBlock,
    Diagnostics,
    commonStuff.align,
    DapStatus,
    commonStuff.space,
    LspStatus,
    commonStuff.space,
    utils.surround(commonStuff.roundedSurround, "bright_bg", { Ruler })
}

local InactiveStatusLine = {
    condition = conditions.is_not_active,
    FileNameEtc, commonStuff.align
}

local SpecialStatusLine = {
    condition = function()
        return conditions.buffer_matches({
            buftype = { "nofile", "prompt", "help", "quickfix" },
            filetype = { "^git.", }
        })
    end,
    HelpFileName
}

local StatusLines = {
    hl = function()
        if conditions.is_active() then
            return "StatusLine"
        else
            return "StatusLineNC"
        end
    end,
    fallthrough = false,
    InactiveStatusLine,
    SpecialStatusLine,
    StatusLine
}

return StatusLines

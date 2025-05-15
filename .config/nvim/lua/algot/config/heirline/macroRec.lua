local utils = require('heirline.utils')

local MacroRec = {
    condition = function()
        return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0
    end,
    provider = "  ",
    hl = { fg = "red", bold = true },
    utils.surround({"[", "]"}, nil, {
        provider = function()
            return vim.fn.reg_recording()
        end,
        hl = { fg = "green", bold = true },
    }),
    update = {
        "RecordingEnter",
        "RecordingLeave"
    }
}

return MacroRec

local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

local roundedSurround = require('algot.config.heirline.bareBones').roundedSurround

local LspStatus = {
    condition = conditions.lsp_attached,
    update = { 'LspAttach', "LspDetach" },
    provider = function()
        local names = {}
        for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
            table.insert(names, server.name)
        end
        return " [" .. table.concat(names, " ") .. "]"
    end,
    hl = { fg = "green", bold = true },
}

return {
    condition = conditions.lsp_attached,
    utils.surround(roundedSurround, "bright_bg", { LspStatus })
}

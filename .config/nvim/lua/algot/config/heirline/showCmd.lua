vim.opt.showcmdloc = 'statusline'

local ShowCmd = {
    condition = function ()
        return vim.o.cmdheight == 0
    end,
    provider = ":%3.5(%S%)",
}

return ShowCmd

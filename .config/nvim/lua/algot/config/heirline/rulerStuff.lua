local Ruler = {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %P = percentage through file of displayed window
    provider = "%7(%l/%3L%):%2c %P",
}

local ScrollBar = {
    static = {
        -- sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
        -- Another variant, because the more choice the better.
        sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
    },
    provider = function(self)
        local current_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local i = math.floor((current_line - 1) / lines * #self.sbar) + 1
        return string.rep(self.sbar[i], 2)
    end,
    hl = { fg = "blue", bg = "bright_bg" },
}


return {
    Ruler,
    ScrollBar
}

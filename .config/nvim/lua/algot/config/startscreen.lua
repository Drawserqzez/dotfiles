local alpha = require('alpha')
local dash = require('alpha.themes.dashboard')

math.randomseed(os.time())

local function pick_colour()
    local colors = {"String", "Identifier", "Keyword", "Number"}
    return colors[math.random(#colors)]
end

local function footer()
    -- local total_plugins = #vim.tbl_keys(packer_plugins)
    local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
    local version = vim.version()
    local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

    return datetime .. nvim_version_info --"   " .. total_plugins .. " plugins" .. nvim_version_info
end

dash.section.header.val = get_logo()
dash.section.header.opts = { hl = pick_colour(), position = 'center' }

dash.section.buttons.val = {
    dash.button("<leader>  nn", " File Explorer"),
    dash.button("<leader>  ff", "󰥨 File Finder"),
    dash.button("c", " Edit Config", ':e $MYVIMRC <CR>'),
    dash.button("r", "󱑟 Reload Config", ':source $MYVIMRC'),
    dash.button("u", " Update Packages", ":Lazy<CR>"),
    dash.button("q", "󰿅 Exit", ":qa<CR>")
}

dash.section.footer.val = footer()
dash.section.footer.opts.hl = "Constant"

alpha.setup(dash.config)

vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])


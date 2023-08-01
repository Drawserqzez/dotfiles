local alpha = require('alpha')
local dash = require('alpha.themes.dashboard')

math.randomseed(os.time())

local function pick_colour()
    local colors = {"String", "Identifier", "Keyword", "Number"}
    return colors[math.random(#colors)]
end

local function footer()
    local total_plugins = #vim.tbl_keys(packer_plugins)
    local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
    local version = vim.version()
    local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

    return datetime .. "   " .. total_plugins .. " plugins" .. nvim_version_info
end

dash.section.header.val = get_logo()
dash.section.header.opts.hl = pick_colour()

dash.section.buttons.val = {
    dash.button("<leader>   n", " File Explorer"),
    dash.button("<leader>  ff", "󰥨 File Finder"),
    dash.button("<leader> cfg", " Edit Config"),
    dash.button("<leader> cfr", "󱑟 Reload Config"),
    dash.button("u", " Update Packages", ":PackerSync<CR>"),
    dash.button("q", "󰿅 Exit", ":qa<CR>")
}

dash.section.footer.val = footer()
dash.section.footer.opts.hl = "Constant"

alpha.setup(dash.opts)

vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])


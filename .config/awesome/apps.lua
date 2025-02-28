local awful = require('awful')
-- local fs = require('gears.filesystem')

local apps = {}

apps.default = {
    terminal = 'wezterm',
    launcher = 'rofi -modi drun -show drun -show-icons -width 22',
    lock = 'xsecurelock',
    screenshot = 'flameshot gui',
    filebrowser = 'nautilus',
    browser = 'firefox',
    editor = 'nvim',
    appmenu = 'rofi -modi window -show window -show-icons -width 22',
    zen = 'flatpak run app.zen_browser.zen',
}

local runOnStartup = {
    'picom'
}

function apps.autostart()
    for _, app in ipairs(runOnStartup) do
        local findme = app
        local firstSpace = app:find(' ')

        if firstSpace then
            findme = app:sub(0, firstSpace - 1)
        else
            awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null; or %s", findme, app), false)
        end
    end
end

return apps

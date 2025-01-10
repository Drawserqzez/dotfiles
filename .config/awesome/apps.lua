local awful = require('awful')
local fs = require('gears.filesystem')

local apps = {}

apps.default {
    terminal = 'wezterm',
    launcher = 'rofi -modi drun -show drun -show-icons -width 22',
    lock = 'xsecurelock',
    screenshot = 'flameshot',
    filebrowser = 'nautilus',
    browser = 'firefox',
    editor = 'nvim'
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
            awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, app), false)
        end
    end
end

return apps

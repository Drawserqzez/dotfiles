local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')

local clickable_container = require('widgets.clickable-container')

local apps = require('apps').default
local dpi = beautiful.xresources.apply_dpi

local ICON_DIR = gears.filesystem.get_configuration_dir() .. '/icons/exit-screen/'
local icon_size = dpi(90)

local exit_screen = {}

local build_button = function(icon)
    local button = wibox.widget {
        wibox.widget {
            wibox.widget {
                wibox.widget {
                    image = icon,
                    widget = wibox.widget.imagebox
                },
                top = dpi(16),
                bottom = dpi(16),
                left = dpi(16),
                right = dpi(16),
                widget = wibox.container.margin
            },
            shape = gears.shape.circle,
            forced_width = icon_size,
            forced_height = icon_size,
            widget = clickable_container
        },
        left = dpi(24),
        right = dpi(24),
        widget = wibox.container.margin
    }
    return button
end

local exit_screen_grabber

local function suspend_command()
    exit_screen.hide()
    awful.spawn.with_shell(apps.lock .. ' & systemctl suspend')
end

local function exit_command()
    awesome.quit()
end

local function lock_command()
    exit_screen.hide()
    awful.spawn.with_shell('sleep 1 && ' .. apps.lock)
end

local function poweroff_command()
    awful.spawn.with_shell('poweroff')
    awful.keygrabber.stop(exit_screen_grabber)
end

local function reboot_command()
    awful.spawn.with_shell('reboot')
    awful.keygrabber.stop(exit_screen_grabber)
end

local poweroff = build_button(ICON_DIR .. 'Power.png', 'Shutdown')
poweroff:connect_signal(
    'button::release',
    function()
        poweroff_command()
    end
)

local reboot = build_button(ICON_DIR .. 'Restart.png', 'Restart')
reboot:connect_signal(
    'button::release',
    function()
        reboot_command()
    end
)

local suspend = build_button(ICON_DIR .. 'Sleep.png', 'Sleep')
suspend:connect_signal(
    'button::release',
    function()
        suspend_command()
    end
)

local exit = build_button(ICON_DIR .. 'Exit.png', 'Logout')
exit:connect_signal(
    'button::release',
    function()
        exit_command()
    end
)

local lock = build_button(ICON_DIR .. 'Lock.png', 'Lock')
lock:connect_signal(
    'button::release',
    function()
        lock_command()
    end
)

awesome.connect_signal('show_exit_screen',
    function()
        exit_screen_grabber = awful.keygrabber.run(
            function(_, key, event)
                if event == 'release' then
                    return
                end

                if key == 's' then
                    suspend_command()
                elseif key == 'e' then
                    exit_command()
                elseif key == 'l' then
                    lock_command()
                elseif key == 'p' then
                    poweroff_command()
                elseif key == 'r' then
                    reboot_command()
                elseif key == 'Escape' or key == 'q' or key == 'x' then
                    exit_screen.hide()
                end
            end
        )
        exit_screen.widget.visible = true
    end
)

local screen_geometry = awful.screen.focused().geometry

exit_screen.widget = wibox({
    x = screen_geometry.x + ((screen_geometry.width - 900) / 2),
    y = screen_geometry.y + ((screen_geometry.height - 300) / 2),
    visible = false,
    ontop = true,
    type = 'splash',
    height = dpi(300),
    width = dpi(900),
    bg = '#333333DD',
    fg = '#FEDFED',
    border_color = '#DEFFC2'
})

function exit_screen.hide()
    awful.keygrabber.stop(exit_screen_grabber)
    exit_screen.widget.visible = false
end

exit_screen.widget:buttons(
    gears.table.join(
        awful.button({}, 2,
            function()
                exit_screen.hide()
            end
        ),
        awful.button({}, 3,
            function()
                exit_screen.hide()
            end
        )
    )
)

exit_screen.widget:setup {
    nil,
    {
        nil,
        {
            poweroff,
            reboot,
            suspend,
            exit,
            lock,
            layout = wibox.layout.fixed.horizontal
        },
        nil,
        expand = 'none',
        layout = wibox.layout.align.horizontal
    },
    nil,
    expand = 'none',
    layout = wibox.layout.align.vertical
}

return exit_screen

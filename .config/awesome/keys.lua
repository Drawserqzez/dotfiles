local awful = require('awful')
local gears = require('gears')
local naughty = require('naughty')
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
local hotkeys_popup = require('awful.hotkeys_popup')
require('awful.hotkeys_popup.keys')

local apps = require('apps').default

local modkey = 'Mod4'
local altkey = 'Mod1'

local keys = {}

keys.globalkeys = gears.table.join(
    awful.key({ modkey }, 'r',
        function()
            print('spawning launcher')
            print(apps.launcher)
            awful.spawn(apps.launcher)
        end,
        {
            description = 'application launcher',
            group = 'launcher'
        }
    ),

    awful.key({ modkey }, 't',
        function()
            awful.spawn(apps.terminal)
        end,
        {
            description = 'open a terminal',
            group = 'launcher'
        }
    ),

    awful.key({ modkey }, 'b',
        function()
            awful.spawn(apps.browser)
        end,
        {
            description = 'open browser',
            group = 'launcher'
        }
    ),

    awful.key({ modkey }, 's',
        hotkeys_popup.show_help,
        {
            description="show help",
            group="awesome"
        }
    ),

    awful.key({ modkey }, 'space',
        function()
            awful.layout.inc(1)
        end,
        {
            description = 'next layout',
            group = 'layout'
        }
    ),

    awful.key({ modkey, 'Shift' }, 'space',
        function()
            awful.layout.inc(-1)
        end,
        {
            description = 'previous layout',
            group = 'layout'
        }
    ),

    awful.key({ modkey, 'Control' }, 'j',
        function()
            awful.screen.focus_relative(1)
        end,
        {
            description = 'focus the next screen',
            group = 'screen'
        }
    ),

    awful.key({ modkey, 'Control' }, 'k',
        function()
            awful.screen.focus_relative(-1)
        end,
        {
            description = 'focus the previous screen',
            group = 'screen'
        }
    ),

    awful.key({ modkey }, 'k',
        function()
            awful.client.focus.bydirection('up')
            if client.focus then
                client.focus:raise()
            end
        end,
        {
            description = 'focus up',
            group = 'client'
        }
    ),

    awful.key({ modkey }, 'j',
        function()
            awful.client.focus.bydirection('down')
            if client.focus then
                client.focus:raise()
            end
        end,
        {
            description = 'focus down',
            group = 'client'
        }
    ),

    awful.key({ modkey }, 'h',
        function()
            awful.client.focus.bydirection('left')
            if client.focus then
                client.focus:raise()
            end
        end,
        {
            description = 'focus left',
            group = 'client'
        }
    ),

    awful.key({ modkey }, 'l',
        function()
            awful.client.focus.bydirection('right')
            if client.focus then
                client.focus:raise()
            end
        end,
        {
            description = 'focus right',
            group = 'client'
        }
    ),

    awful.key({ modkey }, 'Tab',
        function()
            awful.client.focus.byidx(1)
        end,
        {
            description = 'focus next by index',
            group = 'client'
        }
    ),

    awful.key({ modkey, 'Shift' }, 'Tab',
        function()
            awful.client.focus.byidx(-1)
        end,
        {
            description = 'focus previous by index',
            group = 'client'
        }
    ),

    awful.key({ modkey, 'Control' }, 'r',
        awesome.restart,
        {
            description = 'reload awesome',
            group = 'awesome'
        }
    ),

    awful.key({ modkey, 'Shift' }, 'q',
        function()
            awesome.emit_signal('show_exit_screen')
        end,
        {
            description = 'toggle exit screen',
            group = 'hotkeys'
        }
    )
)

for i = 1, 9 do
    keys.globalkeys= gears.table.join(keys.globalkeys,
        awful.key({ modkey }, '#' .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {
                description = 'view tag #' .. i,
                group = 'tag'
            }
        ),

        awful.key({ modkey, 'Shift' }, '#' .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus.move_to_tag(tag)
                    end
                end
            end,
            {
                description = 'move focused client to tag #' .. i,
                group = 'tag'
            }
        )
    )
end

keys.clientkeys = gears.table.join(

    awful.key({ modkey }, 'q',
        function(c)
            c:kill()
        end,
        {
            description = 'close',
            group = 'client'
        }
    )

)

return keys

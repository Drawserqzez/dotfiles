local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')

local popup = wibox {
    bg = beautiful.fg_normal,
    max_widget_size = 500,
    ontop = true,
    height = 50,
    width = 50,
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 8)
    end
}

local function launch(widget)
    popup:setup{
        {
            widget,
            spacing = 32,
            layout = wibox.layout.fixed.vertical
        },
        id = 'a',
        shape_border_width = 1,
        valign = 'center',
        layout = wibox.container.place
    }

    local hide_timer = gears.timer({
        timeout = 2,
        autostart = false
    })

    popup.screen = mouse.screen

    if popup.visible then
        hide_timer:again()
    else
        popup.visible = true
        awful.placement.centered(popup)
        hide_timer:start()
    end

    hide_timer:connect_signal('timeout', function()
        popup.visible = false
        hide_timer:stop()
    end)
end

return {
    launch = launch,
}

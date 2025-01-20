local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local watch = require('awful.widget.watch')

local text_widget = wibox.widget {
    widget = wibox.widget.textbox,
    font = 'GeistMono NF Regular 10',
    ellipsize = 'none',
    id = 'textboxw',
    valign = 'center',
    halign = 'center',
    text = 'tt'
}

local progress_widget = {
    text_widget,
    widget = wibox.container.radialprogressbar,
    value = 0,
    min_value = 0,
    max_value = 1,
    border_color = 'green',
    color = '#ffffff',
    paddings = 1,
    forced_width = 40
}

local battery_widget = wibox.widget {
    progress_widget,
    -- wibox.widget {
    --     widget = wibox.container.constraint,
    -- },
    widget = wibox.container.background,
    fg = '#ffffffcc'
    -- bg = '#ffffff44'
}

local function update_battery_status(battery_status)
    progress_widget.value = battery_status.charge_level / 100

    local text = battery_status.charge_level .. ' %'

    if battery_status.is_charging then
        text = '󱐋 ' .. text
    end

    text_widget:set_text(text)
end

local battery_timer
battery_widget, battery_timer = watch('acpi', 1,
    function(_, stdout, _, _, _)
        if stdout:find("Battery") then
            -- Pattern to match the primary battery information
            local battery_info = stdout:match("Battery 0: (%a+), (%d+)%")

            if battery_info then
                local status, charge_level = battery_info:match("(%a+), (%d+)")

                update_battery_status({
                    is_charging = status == 'Charging' or status == 'Full',
                    charge_level = charge_level
                })
            end
        else
            -- we don't have a battery, so no use in running the watch
            battery_widget.visible = false
            battery_timer:stop()
        end

    end,
    battery_widget
)

return battery_widget

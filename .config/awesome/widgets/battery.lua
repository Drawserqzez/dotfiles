local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local watch = require('awful.widget.watch')

local clickable = require('widgets.clickable-container')

local text_widget = wibox.widget {
    widget = wibox.widget.textbox,
    font = 'GeistMono NF Regular 8',
    ellipsize = 'none',
    id = 'textboxw',
}

local progress_widget = wibox.widget {
    wibox.widget {
        text_widget,
        widget = wibox.container.place,
        fill_vertical = true,
        fill_horizontal = true,
        valign = 'center',
        halign = 'center',
    },
    widget = wibox.container.arcchart,
    min_value = 0,
    max_value = 1,
    value = 0,
    thickness = 2,
    start_angle = 4.71238898, -- 2pi*3/4
    forced_height = 24,
    forced_width = 24,
    rounded_edge = true,
    colors = { '#ffffff', '#ffffff', },
    paddings = 2,
}

local battery_widget = clickable(progress_widget)

Charge = ''

local function update_battery_status(battery_status)
    local charge_percentage = battery_status.charge_level / 100
    require('naughty').notify({ text = battery_status.charge_level })
    progress_widget.values = { 1.0 - (charge_percentage or 0.0), charge_percentage or 0.0 }

    -- local text = battery_status.charge_level .. ' %'
    --
    local text = 'd'

    if battery_status.is_charging then
        text = '󱐋'
    end

    text_widget:set_text(text)
end

-- local battery_timer
-- progress_widget, battery_timer = watch('acpi', 1,
watch('acpi', 1,
    function(callback_widget, stdout, _, _, _)
        Charge = stdout

        if stdout:find("Battery") then
            -- Pattern to match the primary battery information
            local battery_info = stdout:match("Battery 0: (%a+), (%d+)%")

            Charge = Charge .. 'battery_info'
            if battery_info then
                local status, charge_level = battery_info:match("(%a+), (%d+)")

                update_battery_status({
                    is_charging = status == 'Charging' or status == 'Full',
                    charge_level = charge_level
                })
            end
        else
            -- we don't have a battery, so no use in running the watch
            -- progress_widget.visible = false
            -- battery_timer:stop()
            Charge = Charge .. ' not working :(('
        end

    end,
    progress_widget
)

battery_widget:buttons(
    gears.table.join(
        awful.button({}, 1, nil,
            function()
                require('naughty').notify({ title = 'Battery Status', text = Charge })
            end
        )
    )
)

return battery_widget

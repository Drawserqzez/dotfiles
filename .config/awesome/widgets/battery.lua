local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')

local clickable = require('widgets.clickable-container')

local text_widget = wibox.widget {
    widget = wibox.widget.textbox,
    font = 'GeistMono NF Regular 8',
    ellipsize = 'none',
    id = 'textboxw',
    text = 'g'
}

local widget_with_text = wibox.widget {
    text_widget,
    widget = wibox.container.place,
    fill_vertical = true,
    fill_horizontal = true,
    valign = 'center',
    halign = 'center',
}

local progress_widget = wibox.widget {
    widget = wibox.container.arcchart,
    widget_with_text,
    min_value = 0,
    max_value = 1,
    value = 0,
    thickness = 2,
    start_angle = 4.71238898, -- 2pi*3/4
    forced_height = 24,
    forced_width = 24,
    rounded_edge = true,
    colors = { '#ffffff55', '#00ff00' },
    paddings = 2,
}

local battery_widget = clickable(progress_widget)

local charge

local function update_battery_status(widget, battery_status)
    print(battery_status.charge_level)
    print(battery_status.is_charging)
    local charge_percentage = battery_status.charge_level / 100

    widget.values = { 1.0 - (charge_percentage or 0.0), charge_percentage or 0.0 }

    local text = ''
    if battery_status.is_charging then
        text = '󱐋'
    elseif battery_status.is_full then
        text = '󰁹'
    elseif battery_status.charge_level > 75 then
        text = '󱊣'
    elseif battery_status.charge_level > 35 then
        text = '󱊢'
    else
        text = '󱊡'
    end

    text_widget:set_text(text)
end

awful.widget.watch('acpi', 60,
    function(callback_widget, stdout)
        charge = stdout

        -- Split the output into lines
        local lines = {}
        for line in stdout:gmatch("[^\r\n]+") do
            table.insert(lines, line)
        end

        -- Assuming the first line contains the battery information
        local battery_info = lines[1]

        -- Parse the battery information
        local status, percentage = battery_info:match("(%a+), (%d+%%)")

        if status and percentage then
            print(percentage)
            local is_charging = (status:find("Charging") ~= nil)
            local is_full = (status:find("Full") ~= nil)

            local battery_data = {
                is_full = is_full,
                is_charging = is_charging,
                charge_level = tonumber(percentage:sub(1, -2))
            }

            update_battery_status(callback_widget, battery_data)

            charge = percentage
            if is_charging then
                charge = charge .. ' and charging'
            end
        end
    end,
    progress_widget
)

battery_widget:buttons(
    gears.table.join(
        awful.button({}, 1, nil,
            function()
                require('naughty').notify({ title = 'Battery Status', text = charge })
            end
        )
    )
)

return battery_widget

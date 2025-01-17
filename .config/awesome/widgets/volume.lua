local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local watch = require('awful.widget.watch')

local clickable = require('widgets.clickable-container')

local non_filled_colour = '#ffffff55'
local danger_colour = '#e57429ff'
local ok_colour = '#09d6edff'

local speaker_widget = wibox.widget {
    wibox.widget {
        widget = wibox.widget.textbox,
        font = 'GeistMono NF Regular 8',
        ellipsize = 'none',
        id = 'speaker_iconw'
    },
    widget = wibox.container.place,
    fill_vertical = true,
    fill_horizontal = true,
    valign = 'center',
    halign = 'center',
}

local volume_widget = wibox.widget {
    widget = wibox.container.arcchart,
    speaker_widget,
    min_value = 0,
    max_value = 1,
    value = 0,
    thickness = 2,
    start_angle = 4.71238898, -- 2pi*3/4
    forced_height = 24,
    forced_width = 24,
    rounded_edge = true,
    colors = { non_filled_colour, ok_colour },
    paddings = 2,
}

local function update_volume_data(widget, volume_data)
    widget.values = { 1.0 - (volume_data.volume or 0.0), volume_data.volume or 0.0 }

    if volume_data.is_on then
        speaker_widget.children[1]:set_text('󰕾')
    else
        speaker_widget.children[1]:set_text('󰖁')
    end

    if volume_data.volume > 0.5 then
        widget.colors = { non_filled_colour, danger_colour }
    else
        widget.colors = { non_filled_colour, ok_colour }
    end
end

watch('amixer', 1,
    function(callback_widget, stdout, _, _, _)
        local volume = stdout:match("(%d+)%%")
        local is_on = stdout:match("%[(%w+)%]") == 'on'

        local volume_data = {
            volume = volume / 100,
            is_on = is_on
        }

        update_volume_data(callback_widget, volume_data)
    end,
    volume_widget
)

local volume_button = clickable(volume_widget)
volume_button:buttons(
    gears.table.join(
        awful.button({}, 1, nil,
            function ()
                awful.spawn('amixer sset Master toggle')
            end
        ),
        awful.button({}, 4, nil,
            function ()
                awful.spawn('amixer sset Master 5%+')
            end
        ),
        awful.button({}, 5, nil,
            function ()
                awful.spawn('amixer sset Master 5%-')
            end
        )
    )
)

return volume_button

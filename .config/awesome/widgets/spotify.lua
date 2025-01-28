local awful = require('awful')
local watch = require('awful.widget.watch')
local wibox = require('wibox')

local clickable_container = require('widgets.clickable-container')
local gears = require('gears')

local font = 'GeistMono NF Regular 9'

local artist_widget = wibox.widget {
    widget = wibox.widget.textbox,
    font = font,
    id = 'artistw'
}

local playing_icon_widget = wibox.widget {
    wibox.widget {
        widget = wibox.widget.textbox,
        font = 'GeistMono NF Regular 8',
        ellipsize = 'none',
        id = 'playing_iconw'
    },
    widget = wibox.container.place,
    fill_vertical = true,
    fill_horizontal = true,
    valign = 'center',
    halign = 'center',
}

local progress_widget = wibox.widget {
    widget = wibox.container.arcchart,
    playing_icon_widget,
    min_value = 0,
    max_value = 1,
    value = 0,
    thickness = 2,
    start_angle = 4.71238898, -- 2pi*3/4
    forced_height = 24,
    forced_width = 24,
    rounded_edge = true,
    colors = { '#ffffff11', 'black' },
    paddings = 2,
}

local track_widget = wibox.widget {
    widget = wibox.widget.textbox,
    font = font,
    id = 'trackw'
}

local sp_widget = wibox.widget {
    artist_widget,
    progress_widget,
    track_widget,
    wibox.container.margin(nil, 8, 8, 0, 0, nil, false),
    spacing = 8,
    layout = wibox.layout.fixed.horizontal,
}

local sp_button = clickable_container(sp_widget)
sp_button:buttons(
    gears.table.join(
        awful.button({}, 1, nil,
            function ()
                awful.spawn('playerctl -p spotify play-pause', false)
            end
        )
    )
)

local watch_fields = {
    [1] = 'status',
    [2] = 'xesam:artist',
    [3] = 'xesam:title',
    [4] = 'mpris:artUrl',
    [5] = 'position',
    [6] = 'mpris:length',
    [7] = 'album',
    [8] = 'xesam:contentCreated',
}

local watch_cmd = string.format('playerctl -p spotify -f {{%s}} metadata', table.concat(watch_fields, '}};{{'))

local function update_metadata(widget, metadata)
    if metadata.artist ~= nil then
        artist_widget:set_text(metadata.artist)
    end

    if metadata.track ~= nil then
        track_widget:set_text(metadata.track)
    end

    progress_widget.values = { 1.0 - (metadata.progress or 0.0), metadata.progress or 0.0 }

    if metadata.playback_status == 'Playing' then
        if not sp_button.visible then
            sp_button.visible = true
        end

        progress_widget:set_opacity(1)
        artist_widget:set_opacity(1)
        track_widget:set_opacity(1)

        playing_icon_widget.children[1]:set_text('')

        progress_widget:emit_signal('widget::redraw_needed')
        artist_widget:emit_signal('widget::redraw_needed')
        track_widget:emit_signal('widget::redraw_needed')
    elseif metadata.playback_status == 'Paused' then
        if not sp_button.visible then
            sp_button.visible = true
        end

        progress_widget:set_opacity(0.2)
        artist_widget:set_opacity(0.2)
        track_widget:set_opacity(0.2)

        playing_icon_widget.children[1]:set_text('')

        progress_widget:emit_signal('widget::redraw_needed')
        artist_widget:emit_signal('widget::redraw_needed')
        track_widget:emit_signal('widget::redraw_needed')
    else
        sp_button.visible = false;
    end
end

watch(watch_cmd, 1,
    function(callback_widget, stdout, _, _, _)
        local data = gears.string.split(stdout, ';')

        local position, length, progress = tonumber(data[5]), tonumber(data[6])

        if position ~= nil and length ~= nil and length > 0 then
            progress = position / length
        end

        local metadata = {
            playback_status = data[1],
            artist = data[2],
            track = data[3],
            album = data[7],
            position = position,
            length = length,
            progress = progress
        }

        update_metadata(callback_widget, metadata)
    end,
    sp_widget)

return sp_button

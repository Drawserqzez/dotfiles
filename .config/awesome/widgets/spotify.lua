local awful = require('awful')
local watch = require('awful.widget.watch')
local wibox = require('wibox')
local naughty = require('naughty')

local clickable_container = require('widgets.clickable-container')
local gears = require('gears')

local font = 'GeistMono NF Regular 9'

local sp_widget = wibox.widget {
    {
        id = 'playing',
        widget = wibox.widget.textbox,
        font = font
    },
    layout = wibox.layout.fixed.horizontal
}

local sp_button = clickable_container(sp_widget)
sp_button:buttons(
    gears.table.join(
        awful.button({}, 1, nil,
            function ()
                awful.spawn('playerctl -p spotify play-pause')
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
    local playing_widget = widget:get_children_by_id('playing')[1]

    if metadata.playback_status == 'Playing' then
        playing_widget:set_opacity(1)
        playing_widget:set_text('   <   ' .. metadata.artist .. '  ' .. metadata.track .. '   >   ')
        playing_widget:emit_signal('widget::redraw_needed')
    elseif metadata.playback_status == 'Paused' then
        playing_widget:set_opacity(0.2)
        playing_widget:set_text('   <   ' .. metadata.artist .. '  ' .. metadata.track .. '   >   ')
        playing_widget:emit_signal('widget::redraw_needed')
    else
        playing_widget:set_text('   All quiet :)   ')
        playing_widget:set_opacity(0.2)
        playing_widget:emit_signal('widget::redraw_needed')
    end
end

watch(watch_cmd, 1,
    function(callback_widget, stdout, _, _, _)
        local data = gears.string.split(stdout, ';')

        local metadata = {
            playback_status = data[1],
            artist = data[2],
            track = data[3],
            album = data[7]
        }

        update_metadata(callback_widget, metadata)
    end,
    sp_widget)

return sp_button

local wibox = require('wibox')

function build(widget)
    local container = {
        wibox.widget,
        widget,
        widget = wibox.container.background
    }

    local oldCursor, oldWibox

    container:connect_signal(
        'mouse::enter',
        function()
            container.bg = '#ffffff11'
            local w = _G.mouse.current_wibox
            if w then
                oldCursor, oldWibox = w.cursor, w
            end
        end
    )

    container:connect_signal(
        'mouse::leave',
        function()
            container.bg = '#ffffff00'
            if oldWibox then
                oldWibox.cursor = oldCursor
                oldWibox = nil
            end
        end
    )

    container:connect_signal(
        'button::press',
        function()
            container.bg = '#ffffff22'
        end
    )

    container:connect_signal(
        'button::release',
        function()
            container.bg = '#ffffff11'
        end
    )

    return container
end

return build

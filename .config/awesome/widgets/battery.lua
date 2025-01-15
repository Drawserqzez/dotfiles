local awful = require('awful')
local watch = require('awful.widget.watch')
local wibox = require('wibox')

local clickable_container = require('widgets.clickable-container')
local gears = require('gears')

local dpi = require('beautiful').xresources.apply_dpi

local icons_dir = gears.filesystem.get_configuration_dir() .. '/icons/battery/'

local widget = wibox.widget {
    {
        id = 'icon',
        widget = wibox.widget.text,
        -- resize = true,
    },
    layout = wibox.layout.fixed.horizontal
}

local widget_button = clickable_container(wibox.container.margin(widget, dpi(10), dpi(10), dpi(10), dpi(10)))
widget_button:buttons(
    gears.table.join(
        awful.button({}, 1, nil,
            function()
                awful.spawn('xfce4-power-manager-settings')
            end
        )
    )
)

local battery_popup = awful.tooltip({
    objects = { widget_button },
    mode = 'outside',
    align = 'left',
    referred_positions = { 'left', 'right', 'top', 'bottom' }
})

local function show_battery_warning()
    naughty.notify {
        -- icon = icons_dir .. 'battery-alert.svg',
        -- icon_size = dpi(48),
        text = 'Uh oh!',
        title = 'Battery is dying',
        timeout = 5,
        hover_timeout = 0.5,
        position = 'top-middle',
        bg = '#d32f2f',
        fg = '#eee9ef',
        width = 248
    }
end

local battery_checked_at = os.time()

watch('acpi -i', 1,
    function(_, stdout)
        local battery_info = {}
        local capacities = {}

        for s in stdout:gmatch('[^\r\n]+') do
            local status, charge_str, time = string.match(s, '.+: (%a+), (%d%d%d)%%,?.*')

            if status ~= nil then
                table.insert(battery_info, { status = status, charge = tonumber(charge_str) })
            else
                local cap_str = string.match(s, '.+:.+last full capacity (%d+)')
                table.insert(capacities, tonumber(cap_str))
            end
        end

        local capacity = 0
        for _, cap in ipairs(capacities) do
            capacity = capacity + cap
        end

        local charge = 0
        local status

        for i, batt in ipairs(battery_info) do
            if batt.charge >= charge then
                status = batt.status
            end

            charge = charge + batt.charge * capacities[i]
        end

        charge = charge / capacity

        if (charge >= 0 and charge < 15) then
            if status ~= 'Charging' and os.difftime(os.time(), battery_checked_at) > 300 then
                battery_checked_at = os.time()

                show_battery_warning()
            end
        end

        local battery_icon_name = ''
        -- local battery_icon_name = 'battery'
        -- local rounded_charge = math.floor(charge / 10) * 10
        --
        -- if status == 'Charging' then
        --     battery_icon_name = battery_icon_name .. '-charging'
        -- elseif status == 'Full' or rounded_charge > 80 then
        --     battery_icon_name = battery_icon_name .. '-full'
        -- elseif (rounded_charge == 0) then
        --     battery_icon_name = battery_icon_name .. '-empty'
        -- elseif (rounded_charge <= 80 and rounded_charge > 40) then
        --     battery_icon_name = battery_icon_name .. '-empty-2'
        -- elseif (rounded_charge <= 40) then
        --     battery_icon_name = battery_icon_name .. '-empty-1'
        -- end
        --
        -- widget.icon:set_image(icons_dir .. battery_icon_name .. '.svg')

        widget.icon:set_text(battery_icon_name)

        battery_popup.text = string.gsub(stdout, '\n$', '')
        collectgarbage('collect')

    end,
    widget
)

return widget_button


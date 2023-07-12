-------------------------------------------------
-- Spotify Shell for Awesome Window Manager
-- Simplifies interaction with Spotify for Linux
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/spotify-shell

-- @author Pavel Makhov
-- @copyright 2018 Pavel Makhov
-------------------------------------------------

local awful = require("awful")
local gfs = require("gears.filesystem")
local wibox = require("wibox")
local gears = require("gears")

local ICON = '/usr/share/icons/al-candy-icons/apps/scalable/spotify-linux-48x48.svg'

local spotify_shell = awful.widget.prompt()

local w = wibox {
    bg = '#0E1428',
    border_width = 1,
    border_color = '#00ffff',
    max_widget_size = 500,
    ontop = true,
    height = 40,
    width = 220,
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 5)
    end
}

w:setup {
    {
        {
            image = ICON,
            widget = wibox.widget.imagebox,
            resize = false
        },
        id = 'icon',
        top = 1,
        left = 2,
        layout = wibox.container.margin
    },
    {
        layout = wibox.container.margin,
        left = 2,
        spotify_shell,
    },
    id = 'left',
    layout = wibox.layout.fixed.horizontal
}

local function launch()
    w.visible = true

    awful.placement.top(w, { margins = {top = 40}, parent = awful.screen.focused()})
    awful.prompt.run{
        prompt = "<b></b>: ",
        bg_cursor = '#84bd00',
        textbox = spotify_shell.widget,
        history_path = gfs.get_dir('cache') .. '/spotify_history',
        exe_callback = function(input_text)
            if not input_text or #input_text == 0 then return end
            awful.spawn("sp " .. input_text)
        end,
        done_callback = function()
            w.visible = false
        end
    }
end

return {
    launch = launch
}

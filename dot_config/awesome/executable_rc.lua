--[[

     Awesome WM configuration template
     https://github.com/awesomeWM

     Freedesktop : https://github.com/lcpz/awesome-freedesktop

     Copycats themes : https://github.com/lcpz/awesome-copycats

     lain : https://github.com/lcpz/lain

--]]

-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

--https://awesomewm.org/doc/api/documentation/05-awesomerc.md.html
-- Standard awesome library
local gears         = require("gears") --Utilities such as color parsing and objects
local awful         = require("awful") --Everything related to window managment
                      require("awful.autofocus")
-- Widget and layout library
local wibox         = require("wibox")
local machi	    = require("layout-machi")

-- Theme handling library
local beautiful     = require("beautiful")

-- Notification library
local naughty       = require("naughty")
naughty.config.defaults['icon_size'] = 100

--local menubar       = require("menubar")

local lain          = require("lain")
local freedesktop   = require("freedesktop")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      require("awful.hotkeys_popup.keys")
local my_table      = awful.util.table or gears.table -- 4.{0,1} compatibility
local dpi           = require("beautiful.xresources").apply_dpi
-- }}}
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')


-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}



-- {{{ Autostart windowless processes
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

run_once({ "unclutter -root" }) -- entries must be comma-separated
-- }}}

-- This function implements the XDG autostart specification
--[[
awful.spawn.with_shell(
    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
    'xrdb -merge <<< "awesome.started:true";' ..
    -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
    'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart"' -- https://github.com/jceb/dex
)
--]]

-- }}}

-- {{{ Variable definitions

local themes = {
    "powerarrow",      		-- 2
}

-- choose your theme here
local chosen_theme = themes[1]

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)
-- Bling and Rubato
local bling = require("bling")
local rubato = require("rubato")

-- Scratchpads
local anim_y = rubato.timed {
    pos = 1090,
    rate = 60,
    easing = rubato.quadratic,
    intro = 0.1,
    duration = 0.3,
    awestore_compat = true -- This option must be set to true.
}
local spotify_scratch = bling.module.scratchpad:new {
	command					= "spotify",
	rule					= { instance = "spotify" },
	sticky					= false,
	autoclose				= true,
	floating				= true,
	geometry				= {x=200, y=50, height=700, width=1100},
	reapply					= true,
	dont_focus_before_close = false,
    rubato = {y = anim_y}
}

local discord_scratch = bling.module.scratchpad:new {
	command					= "discord",
	rule					= { instance = "discord" },
	sticky					= false,
	autoclose				= false,
	floating				= true,
	geometry				= {x=200, y=50, height=700, width=1100},
	reapply					= true,
	dont_focus_before_close = false,
    rubato = {y = anim_y}
}

local alacritty_scratch = bling.module.scratchpad:new {
	command					= "alacritty --class spad",
	rule					= { instance = "spad" },
	sticky					= false,
	autoclose				= true,
	floating				= true,
	geometry				= {x=200, y=50, height=700, width=1100},
	reapply					= true,
	dont_focus_before_close = false,
    rubato = {y = anim_y}
}

-- modkey or mod4 = super key
local modkey       = "Mod4"
local altkey       = "Mod1"
local modkey1      = "Control"

-- personal variables
--change these variables if you want
local browser1          = "brave"

local editor            = os.getenv("EDITOR") or "nvim"
local editorgui         = "code"
local filemanager       = "dolphin"
local mailclient        = "thunderbird"
local mediaplayer       = "spotify"
local terminal          = "alacritty"
local virtualmachine    = "virtualbox"

-- awesome variables
awful.util.terminal = terminal
--awful.util.tagnames = {  "", "", "", "", "" }
--awful.util.tagnames = { "⠐", "⠡", "⠲", "⠵", "⠻", "⠿" }
--awful.util.tagnames = { "⌘", "", "⌥", "ℵ" }
--awful.util.tagnames = { " ", " ", " ", " " }
--awful.util.tagnames = { "  ", "  ", "  ", "  " }
awful.util.tagnames = { "ハ", "メ", "ー", "ス" }
-- Use this : https://fontawesome.com/cheatsheet
--awful.util.tagnames = { "", "", "", "", "" }
awful.layout.suit.tile.left.mirror = true

awful.layout.layouts = {
    bling.layout.deck,
    lain.layout.cascade,
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.tile.left,
    machi.default_layout,
--    awful.layout.suit.tile.bottom,
--    awful.layout.suit.tile.top,
--    awful.layout.suit.fair,
  --awful.layout.suit.fair.horizontal,
--awful.layout.suit.spiral,
  --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
  --  lain.layout.cascade.tile,
    lain.layout.centerwork,
  --  lain.layout.centerwork.horizontal,
  --  lain.layout.termfair,
  --  lain.layout.termfair.center,
}

machi.editor.nested_layouts = {
	bling.layout.deck,
	lain.layout.cascade,
	awful.layout.suit.tile,
	awful.layout.suit.floating,
	awful.layout.suit.tile.left,

}

require("beautiful").layout_machi = machi.get_icon()

awful.util.taglist_buttons = my_table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = my_table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            --c:emit_signal("request::activate", "tasklist", {raise = true})<Paste>

            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() and c.first_tag then
                c.first_tag:view_only()
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
        end
    end),
    awful.button({ }, 3, function ()
        local instance = nil

        return function ()
            if instance and instance.wibox.visible then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({theme = {width = dpi(250)}})
            end
        end
    end),
    awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = dpi(2)
lain.layout.cascade.tile.offset_y      = dpi(32)
lain.layout.cascade.tile.extra_padding = dpi(5)
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))
-- }}}




-- {{{ Menu
local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "arandr", "arandr" },
}

awful.util.mymainmenu = freedesktop.menu.build({
    before = {
        { "Awesome", myawesomemenu },
        --{ "Atom", "atom" },
        -- other triads can be put here
    },
    after = {
        { "Terminal", terminal },
        { "Log out", function() awesome.quit() end },
        { "Sleep", "systemctl suspend" },
        { "Restart", "systemctl reboot" },
        { "Shutdown", "systemctl poweroff" },
        -- other triads can be put here
    }
})
-- hide menu when mouse leaves it
--awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function() awful.util.mymainmenu:hide() end)

--menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}



-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function (s)
    local only_one = #s.tiled_clients == 1
    for _, c in pairs(s.clients) do
        if only_one and not c.floating or c.maximized then
            c.border_width = 2
        else
            c.border_width = beautiful.border_width
        end
    end
end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s)
    s.systray = wibox.widget.systray()
    s.systray.visible = true
 end)
-- }}}



-- {{{ Mouse bindings
root.buttons(my_table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}



-- {{{ Key bindings
globalkeys = my_table.join(

    -- {{{ Personal keybindings
    awful.key({ modkey }, "w", function () awful.util.spawn( browser1 ) end,
        {description = browser1, group = "function keys"}),
    -- ScratchPads
    awful.key({ modkey,        }, "d", function () alacritty_scratch:toggle() end,
        {description = "Alacritty ScratcPad", group = "ScratchPads"}),
    awful.key({ modkey }, "x", function() spotify_scratch:toggle() end,
  	{ description = "spotify scratchpad", group = "ScratchPads"}),
    awful.key({ modkey }, "c", function() discord_scratch:toggle() end,
  	{ description = "spotify scratchpad", group = "ScratchPads"}),

    -- Volume Control
    awful.key({ modkey }, "]", function() volume_widget:inc(5) end,
        {description = "IncreaseVolume", group= "Music"}),
    awful.key({ modkey }, "[", function() volume_widget:dec(5) end,
        {description = "DecreaseVolume", group= "Music"}),
    awful.key({ modkey }, "\\", function() volume_widget:toggle() end,
        {description = "ToggleMute/Unmute", group= "Music"}),


    -- super + ... function keys
    awful.key({ modkey }, "F1", function () awful.util.spawn( browser1 ) end,
        {description = browser1, group = "function keys"}),
    awful.key({ modkey }, "F2", function () awful.util.spawn( editorgui ) end,
        {description = editorgui , group = "function keys" }),
    awful.key({ modkey }, "F3", function () awful.util.spawn( "inkscape" ) end,
        {description = "inkscape" ,group = "function keys" }),
    awful.key({ modkey }, "F4", function () awful.util.spawn( "gimp" ) end,
        {description = "gimp" , group = "function keys" }),
    awful.key({ modkey }, "F5", function () awful.util.spawn( "vlc --video-on-top" ) end,
        {description = "vlc" , group = "function keys" }),
    awful.key({ modkey }, "F6", function () awful.util.spawn( filemanager ) end,
        {description = filemanager , group = "function keys" }),
    awful.key({ modkey }, "F7", function () awful.util.spawn( mediaplayer ) end,
        {description = mediaplayer , group = "function keys" }),
    awful.key({ modkey }, "z", function () awful.util.spawn( "./.config/rofi/applets/bin/powermenu.sh" ) end,
        {description = "PowerMenu" , group = "function keys" }),
    awful.key({ modkey }, "r", function () awful.util.spawn( "./.config/rofi/launchers/type-5/launcher.sh" ) end,
        {description = "rofi" , group = "function keys" }),

    awful.key({ modkey, modkey1 }, "m", function () awful.util.spawn( "./.config/rofi/launchers/Rofi-calc/launcher.sh" ) end,
        {description = "rofi-calc" , group = "function keys" }),

    awful.key({ modkey }, "u", function () awful.util.spawn("./.config/rofi/launchers/keep/launcher.sh") end,
        {description = "rofi-keepass" , group = "function keys" }),

    awful.key({ modkey, modkey1 }, ".", function () awful.util.spawn( "variety --next" ) end,
        {description = "Wallpaper Next" , group = "function keys" }),

    awful.key({ modkey, modkey1 }, ",", function () awful.util.spawn( "variety --previous" ) end,
        {description = "Wallpaper Previous" , group = "function keys" }),

    awful.key({ modkey, modkey1 }, "/", function () awful.util.spawn( "variety -f" ) end,
        {description = "Wallpaper Fav" , group = "function keys" }),

    -- super + ...
    awful.key({ modkey }, "e", function () awful.util.spawn( editorgui ) end,
        {description = "run gui editor", group = "super"}),
 awful.key({altkey}, "Tab", function()
     awesome.emit_signal("bling::window_switcher::turn_on")
 end, {description = "Window Switcher", group = "bling"}),

    awful.key({ modkey }, "t", function () awful.util.spawn( terminal ) end,
        {description = "terminal", group = "super"}),
    awful.key({ modkey }, "v", function () awful.util.spawn( "pavucontrol" ) end,
        {description = "pulseaudio control", group = "super"}),
    --awful.key({ modkey }, "u", function () awful.screen.focused().mypromptbox:run() end,
          --{description = "run prompt", group = "super"}),
    awful.key({ modkey }, "Escape", function () awful.util.spawn( "xkill" ) end,
        {description = "Kill proces", group = "hotkeys"}),

    -- super + shift + ..


    -- ctrl + shift + ...


    -- ctrl+alt +  ...
    awful.key({ modkey1, altkey   }, "k", function() awful.util.spawn( "arcolinux-logout" ) end,
        {description = scrlocker, group = "alt+ctrl"}),

    awful.key({ modkey1, altkey   }, "o", function() awful.spawn.with_shell("$HOME/.config/awesome/scripts/picom-toggle.sh") end,
        {description = "Picom toggle", group = "alt+ctrl"}),
    awful.key({ modkey1, altkey   }, "u", function() awful.util.spawn( "pavucontrol" ) end,
        {description = "pulseaudio control", group = "alt+ctrl"}),
    awful.key({ modkey1, altkey   }, "p", function() awful.util.spawn( "pamac-manager" ) end,
        {description = "Pamac Manager", group = "alt+ctrl"}),

    -- alt + ...

    -- awful.key({ altkey }, "F5", function () awful.spawn.with_shell( "xlunch --config ~/.config/xlunch/default.conf --input ~/.config/xlunch/entries.dsv" ) end,
    --    {description = "Xlunch app launcher", group = "altkey"}),

    -- screenshots
    awful.key({modkey, "Shift"}, "s", function () awful.util.spawn("flameshot gui") end,
        {description = "flameshot", group = "screenshots"}),

    -- Personal keybindings}}}


    -- Hotkeys Awesome

    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
        {description = "show help", group="awesome"}),

    -- Tag browsing with modkey
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
        {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
        {description = "view next", group = "tag"}),
    awful.key({ altkey,           }, "Escape", awful.tag.history.restore,
        {description = "go back", group = "tag"}),



     -- Tag browsing modkey + tab
    awful.key({ modkey,           }, "Tab",   awful.tag.viewnext,
        {description = "view next", group = "tag"}),
    awful.key({ modkey, "Shift"   }, "Tab",  awful.tag.viewprev,
        {description = "view previous", group = "tag"}),


    -- Non-empty tag browsing
    --awful.key({ modkey }, "Left", function () lain.util.tag_view_nonempty(-1) end,
              --{description = "view  previous nonempty", group = "tag"}),
   -- awful.key({ modkey }, "Right", function () lain.util.tag_view_nonempty(1) end,
             -- {description = "view  next nonempty", group = "tag"}),

    -- Default client focus
    awful.key({ altkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ altkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- By direction client focus
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "client"}),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "client"}),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "client"}),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "client"}),


        -- By direction client focus with arrows
        awful.key({ modkey1, modkey }, "Down",
            function()
                awful.client.focus.global_bydirection("down")
                if client.focus then client.focus:raise() end
            end,
            {description = "focus down", group = "client"}),
        awful.key({ modkey1, modkey }, "Up",
            function()
                awful.client.focus.global_bydirection("up")
                if client.focus then client.focus:raise() end
            end,
            {description = "focus up", group = "client"}),
        awful.key({ modkey1, modkey }, "Left",
            function()
                awful.client.focus.global_bydirection("left")
                if client.focus then client.focus:raise() end
            end,
            {description = "focus left", group = "client"}),
        awful.key({ modkey1, modkey }, "Right",
            function()
                awful.client.focus.global_bydirection("right")
                if client.focus then client.focus:raise() end
            end,
            {description = "focus right", group = "client"}),


    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey1,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Floating Window Managing
awful.key({ modkey, "Shift"  }, "t",      function (c) client.focus.ontop = not client.focus.ontop            end,
                {description = "toggle keep on top", group = "client"}),
awful.key({ altkey }, "Next",  function (c) client.focus:relative_move( 20,  20, -40, -40) end,
		{description = "Size Inc of Floating Client", group = "client"}),
awful.key({ altkey }, "Prior", function (c) client.focus:relative_move(-20, -20,  40,  40) end,
		{description = "Size Dec of Floating Client", group = "client"}),
awful.key({ altkey }, "Down",  function (c) client.focus:relative_move(  0,  20,   0,   0) end,
		{description = "Move Down Floating Client", group = "client"}),
awful.key({ altkey }, "Up",    function (c) client.focus:relative_move(  0, -20,  0,   0) end,
		{description = "Move Up Floating Client", group = "client"}),
awful.key({ altkey }, "Left",  function (c) client.focus:relative_move(-20,   0,   0,   0) end,
		{description = "Move Left Floating Client", group = "client"}),
awful.key({ altkey }, "Right", function (c) client.focus:relative_move( 20,   0,   0,   0) end,
		{description = "Move Right Floating CLient", group = "client"}),


    -- Show/Hide Wibox
    awful.key({ modkey }, "b", function ()
            for s in screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end,
        {description = "toggle wibox", group = "awesome"}),

 -- Show/Hide Systray
    awful.key({ modkey }, "-", function ()
    awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
    end, {description = "Toggle systray visibility", group = "awesome"}),

 -- Show/Hide Systray
    awful.key({ modkey }, "KP_Subtract", function ()
    awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
    end, {description = "Toggle systray visibility", group = "awesome"}),



    -- On the fly useless gaps change
    awful.key({ altkey, "Control" }, "j", function () lain.util.useless_gaps_resize(1) end,
              {description = "increment useless gaps", group = "tag"}),
    awful.key({ altkey, "Control" }, "h", function () lain.util.useless_gaps_resize(-1) end,
              {description = "decrement useless gaps", group = "tag"}),

    -- Dynamic tagging
    awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end,
              {description = "add new tag", group = "tag"}),
    awful.key({ modkey, "Control" }, "r", function () lain.util.rename_tag() end,
              {description = "rename tag", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
              {description = "move tag to the left", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
              {description = "move tag to the right", group = "tag"}),
    awful.key({ modkey, "Shift" }, "y", function () lain.util.delete_tag() end,
              {description = "delete tag", group = "tag"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = terminal, group = "super"}),
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
     awful.key({ modkey, "Shift"   }, "x", awesome.quit,
              {description = "quit awesome", group = "awesome"}),


	-- LAYOUT MACHI --
	
	awful.key({ modkey, altkey  }, ".",    function () machi.default_editor.start_interactive() end,
              {description = "edit the current layout if it is a machi layout", group = "layout"}),
    awful.key({ modkey, "Shift"          }, ".",    function () machi.switcher.start(client.focus) end,
              {description = "switch between windows for a machi layout", group = "layout"}),

	-- BLING --
-- Tabbed
    awful.key({ altkey, "Shift"   }, "/",     function () bling.module.tabbed.pick()           end,
              {description = "increase master width factor", group = "bling"}),
    awful.key({ altkey, "Shift"   }, ".",     function () bling.module.tabbed.iter()           end,
              {description = "decrease master width factor", group = "bling"}),
    awful.key({ altkey, "Shift"   }, ",",     function () bling.module.tabbed.pop()            end,
              {description = "decrease master width factor", group = "bling"}),
-- Layout
    awful.key({ altkey, "Shift"   }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ altkey, "Shift"   }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    --awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
             -- {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Widgets popups
    --awful.key({ altkey, }, "c", function () lain.widget.calendar.show(7) end,
        --{description = "show calendar", group = "widgets"}),
    --awful.key({ altkey, }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end,
              --{description = "show filesystem", group = "widgets"}),
    --awful.key({ altkey, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end,
              --{description = "show weather", group = "widgets"}),

    -- Brightness
    awful.key({ }, "XF86MonBrightnessUp", function () os.execute("xbacklight -inc 10") end,
              {description = "+10%", group = "hotkeys"}),
    awful.key({ }, "XF86MonBrightnessDown", function () os.execute("xbacklight -dec 10") end,
              {description = "-10%", group = "hotkeys"}),

    -- ALSA volume control
    --awful.key({ modkey1 }, "Up",
    awful.key({ }, "XF86AudioRaiseVolume",
        function ()
            os.execute(string.format("amixer -q set %s 1%%+", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    --awful.key({ modkey1 }, "Down",
    awful.key({ }, "XF86AudioLowerVolume",
        function ()
            os.execute(string.format("amixer -q set %s 1%%-", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({ }, "XF86AudioMute",
        function ()
            os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({ modkey1, "Shift" }, "m",
        function ()
            os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({ modkey1, "Shift" }, "0",
        function ()
            os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
            beautiful.volume.update()
        end),

    --Media keys supported by vlc, spotify, audacious, xmm2, ...
    --awful.key({}, "XF86AudioPlay", function() awful.util.spawn("playerctl play-pause", false) end),
    --awful.key({}, "XF86AudioNext", function() awful.util.spawn("playerctl next", false) end),
    --awful.key({}, "XF86AudioPrev", function() awful.util.spawn("playerctl previous", false) end),
    --awful.key({}, "XF86AudioStop", function() awful.util.spawn("playerctl stop", false) end),

    -- MPD control

    -- Copy primary to clipboard (terminals to gtk)
    --awful.key({ modkey }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end,
             -- {description = "copy terminal to gtk", group = "hotkeys"}),
     --Copy clipboard to primary (gtk to terminals)
    --awful.key({ modkey }, "v", function () awful.spawn.with_shell("xsel -b | xsel") end,
              --{description = "copy gtk to terminal", group = "hotkeys"}),


    -- Default
    --[[ Menubar

    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "super"})
    --]]

    awful.key({ altkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"})
    --]]
)

clientkeys = my_table.join(
    awful.key({ altkey, "Shift"   }, "m",      lain.util.magnify_client,
              {description = "magnify client", group = "client"}),
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "hotkeys"}),
    awful.key({ modkey, },           "q",      function (c) c:kill()                         end,
              {description = "close", group = "hotkeys"}),
    awful.key({ modkey, "Shift" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    --awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              --{description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = "tag"}
        descr_toggle = {description = "toggle tag #", group = "tag"}
        descr_move = {description = "move focused client to tag #", group = "tag"}
        descr_toggle_focus = {description = "toggle focused client on tag #", group = "tag"}
    end
    globalkeys = my_table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  descr_view),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  descr_toggle),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                              tag:view_only()
                          end
                     end
                  end,
                  descr_move),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  descr_toggle_focus)
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}



-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Titlebars
    { rule_any = { type = { "dialog", "normal" } },
      properties = { titlebars_enabled = false } },
          -- Set applications to always map on the tag 2 on screen 1.
    --{ rule = { class = "Subl" },
        --properties = { screen = 1, tag = awful.util.tagnames[2], switchtotag = true  } },

    { rule = { class = editorgui },
          properties = { maximized = true } },

    { rule = { class = "Geany" },
          properties = { maximized = false, floating = false } },

    -- { rule = { class = "Thunar" },
    --     properties = { maximized = false, floating = false } },

    { rule = { class = "Gimp*", role = "gimp-image-window" },
          properties = { maximized = true } },

    { rule = { class = "Gnome-disks" },
          properties = { maximized = true } },

    { rule = { class = "inkscape" },
          properties = { maximized = true } },

    { rule = { class = mediaplayer },
          properties = { maximized = true } },

    { rule = { class = "Vlc" },
          properties = { maximized = true } },

    { rule = { class = "VirtualBox Manager" },
          properties = { maximized = true } },

    { rule = { class = "VirtualBox Machine" },
          properties = { maximized = true } },

    { rule = { class = "Vivaldi-stable" },
          properties = { maximized = false, floating = false } },
	  
    { rule = { class = "Variety" },
          properties = { maximized = false, floating = true } },

    { rule = { class = "Vivaldi-stable" },
          properties = { callback = function (c) c.maximized = false end } },

    --IF using Vivaldi snapshot you must comment out the rules above for Vivaldi-stable as they conflict
--    { rule = { class = "Vivaldi-snapshot" },
--          properties = { maximized = false, floating = false } },

--    { rule = { class = "Vivaldi-snapshot" },
--          properties = { callback = function (c) c.maximized = false end } },

    { rule = { class = "Xfce4-settings-manager" },
          properties = { floating = false } },

    { rule = { class = "zoom" },
    	  properties = {floating = true} },

    { rule = { class = "thunar" },
    	  properties = {floating = true} },



    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Arcolinux-welcome-app.py",
          "Blueberry",
          "Galculator",
          "Gnome-font-viewer",
          "Gpick",
          "Imagewriter",
          "Font-manager",
          "Kruler",
          "MessageWin",  -- kalarm.
          "arcolinux-logout",
          "Peek",
          "Skype",
          "System-config-printer.py",
          "Sxiv",
          "Unetbootin.elf",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer",
	  "gnome-pie",
	  "variety",
	  "Variety Preferences",
	  "pavucontrol",
	  "huiontablet",
	  "Pavucontrol",
	  "dolphin",
	  "Variety Images",
          "Xfce4-terminal"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
          "Preferences",
          "setup",
        }
      }, properties = { floating = true }},

          -- Floating clients but centered in screen
    { rule_any = {
       	class = {
       		"Polkit-gnome-authentication-agent-1",
			"Arcolinux-calamares-tool.py"
				},
				},
      	properties = { floating = true },
	      	callback = function (c)
    		  awful.placement.centered(c,nil)
       		end }
}
-- }}}

-- Window Switcher

bling.widget.window_switcher.enable {
    type = "thumbnail", -- set to anything other than "thumbnail" to disable client previews

    -- keybindings (the examples provided are also the default if kept unset)
    hide_window_switcher_key = "Escape", -- The key on which to close the popup
    minimize_key = "n",                  -- The key on which to minimize the selected client
    unminimize_key = "N",                -- The key on which to unminimize all clients
    kill_client_key = "q",               -- The key on which to close the selected client
    cycle_key = "Tab",                   -- The key on which to cycle through all clients
    previous_key = "Left",               -- The key on which to select the previous client
    next_key = "Right",                  -- The key on which to select the next client
    vim_previous_key = "h",              -- Alternative key on which to select the previous client
    vim_next_key = "l",                  -- Alternative key on which to select the next client

    cycleClientsByIdx = awful.client.focus.byidx,               -- The function to cycle the clients
    filterClients = awful.widget.tasklist.filter.currenttags,   -- The function to filter the viewed clients
}


-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = my_table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {size = dpi(21)}) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)


bling.module.flash_focus.enable()
-- Enable sloppy focus, so that focus follows mouse.

beautiful.border_focus = "#343dba"
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- Autostart applications
awful.spawn.with_shell("~/.config/awesome/autostart.sh")
--awful.spawn.with_shell("compton")
awful.spawn.with_shell("picom -b --animations --animation-window-mass 0.5 --animation-for-open-window zoom --animation-stiffness 350 --config  $HOME/.config/awesome/picom.conf")
--awful.spawn.with_shell("./usr/lib/huiontablet/huiontablet.sh")
--awful.spawn.with_shell("feh --bg-fill --randomize ~/Downloads/Wallpapers/papes/* &")

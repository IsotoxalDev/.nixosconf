-- isotoxal hyprland config
-- https://wiki.hypr.land/Configuring/Start/

--------------------
---- MONITORS ----
--------------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

--------------------
---- PROGRAMS ----
--------------------

local terminal    = "kitty --single-instance"
local fileManager = "kitty -e yazi"
local menu        = "wofi --show drun"

--------------------
---- AUTOSTART ----
--------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd(os.getenv("HOME") .. "/.config/scripts/wallpaper-rotate.sh")
    hl.exec_cmd(os.getenv("HOME") .. "/.config/scripts/battery-monitor.sh")
    hl.exec_cmd("swayidle -w timeout 180 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' timeout 600 'systemctl suspend' before-sleep 'swaylock -f -c 000000'")
end)

--------------------
---- ENV VARS ----
--------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("__NV_PRIME_RENDER_OFFLOAD", "1")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

--------------------
---- APPEARANCE ----
--------------------

hl.config({
    general = {
        gaps_in  = 4,
        gaps_out = 8,
        border_size = 2,
        col = {
            active_border   = { colors = {c.accent, c.accentDim}, angle = 45 },
            inactive_border = c.border,
        },
        resize_on_border = true,
        layout = "dwindle",
    },

    decoration = {
        rounding = 8,
        dim_inactive = true,
        dim_strength = 0.15,
        shadow = {
            enabled      = true,
            range        = 8,
            render_power = 3,
            color        = c.shadow,
        },
        blur = {
            enabled            = true,
            size               = 6,
            passes             = 3,
            vibrancy           = 0.1696,
            popups             = true,
            popups_ignorealpha = 0.2
        },
    },

    animations = {
        enabled = true,
    },
})

-- Curves
hl.curve("myBezier",    { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve("quick",       { type = "bezier", points = { {0.15, 0},   {0.1, 1}    } })
hl.curve("almostLinear",{ type = "bezier", points = { {0.5, 0.5},  {0.75, 1}   } })

-- Animations
hl.animation({ leaf = "global",        enabled = true,  speed = 8,    bezier = "default"      })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4,    bezier = "myBezier"     })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4,    bezier = "myBezier",    style = "popin 80%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 4,    bezier = "quick",       style = "popin 80%" })
hl.animation({ leaf = "border",        enabled = true,  speed = 10,   bezier = "default"      })
hl.animation({ leaf = "fade",          enabled = true,  speed = 4,    bezier = "quick"        })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 4,    bezier = "almostLinear", style = "fade" })

hl.config({
    dwindle = {
        preserve_split = true,
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})

--------------------
---- INPUT ----
--------------------

hl.config({
    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad = {
            natural_scroll       = true,
            disable_while_typing = true,
            tap_to_click         = true,
            scroll_factor        = 0.3,
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

--------------------
---- KEYBINDINGS ----
--------------------

local mod = "SUPER"

-- Apps
hl.bind(mod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + B",      hl.dsp.exec_cmd("firefox"))
hl.bind(mod .. " + E",      hl.dsp.exec_cmd(fileManager))
hl.bind(mod .. " + R",      hl.dsp.exec_cmd(menu))

-- Window management
hl.bind(mod .. " + Q",         hl.dsp.window.close())
hl.bind(mod .. " + F",         hl.dsp.window.fullscreen())
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + P",         hl.dsp.window.pseudo())
hl.bind(mod .. " + T",         hl.dsp.layout("togglesplit"))

-- Focus (vim keys)
hl.bind(mod .. " + h",     hl.dsp.focus({ direction = "left"  }))
hl.bind(mod .. " + l",     hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + k",     hl.dsp.focus({ direction = "up"    }))
hl.bind(mod .. " + j",     hl.dsp.focus({ direction = "down"  }))
hl.bind(mod .. " + left",  hl.dsp.focus({ direction = "left"  }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + up",    hl.dsp.focus({ direction = "up"    }))
hl.bind(mod .. " + down",  hl.dsp.focus({ direction = "down"  }))

-- Move windows (vim keys)
hl.bind(mod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left"  }))
hl.bind(mod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up"    }))
hl.bind(mod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down"  }))

-- Resize windows (Super+Alt + vim keys)
hl.bind(mod .. " + ALT + h", function() hl.dispatch("resizeactive", "-50 0") end)
hl.bind(mod .. " + ALT + l", function() hl.dispatch("resizeactive", "50 0") end)
hl.bind(mod .. " + ALT + k", function() hl.dispatch("resizeactive", "0 -50") end)
hl.bind(mod .. " + ALT + j", function() hl.dispatch("resizeactive", "0 50") end)

hl.bind(mod .. " + ALT + left",  function() hl.dispatch("resizeactive", "-50 0") end)
hl.bind(mod .. " + ALT + right", function() hl.dispatch("resizeactive", "50 0") end)
hl.bind(mod .. " + ALT + up",    function() hl.dispatch("resizeactive", "0 -50") end)
hl.bind(mod .. " + ALT + down",  function() hl.dispatch("resizeactive", "0 50") end)

-- Power profiles
hl.bind(mod .. " + F1", hl.dsp.exec_cmd("powerprofilesctl set power-saver && notify-send 'Power Mode' 'Power Saver 🔋'"))
hl.bind(mod .. " + F2", hl.dsp.exec_cmd("powerprofilesctl set balanced && notify-send 'Power Mode' 'Balanced ⚖'"))
hl.bind(mod .. " + F3", hl.dsp.exec_cmd("powerprofilesctl set performance && notify-send 'Power Mode' 'Performance 🔥'"))

-- Workspaces
for i = 1, 9 do
    hl.bind(mod .. " + " .. i,             hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. i,     hl.dsp.window.move({ workspace = i }))
end
hl.bind(mod .. " + " .. 0,             hl.dsp.focus({ workspace = 10 }))
hl.bind(mod .. " + SHIFT + " .. 0,     hl.dsp.window.move({ workspace = 10 }))

-- Special workspace (scratchpad)
hl.bind(mod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Mouse
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + mouse:272",  hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273",  hl.dsp.window.resize(), { mouse = true })

-- Media keys
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"),                                  { locked = true })
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"),                            { locked = true })
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"),                              { locked = true })

-- System
hl.bind(mod .. " + SHIFT + Q", hl.dsp.exit())
hl.bind(mod .. " + Escape",         hl.dsp.exec_cmd("swaylock -f -c 000000"))
hl.bind(mod .. " + SHIFT + R", hl.dsp.exec_cmd("sudo nixos-rebuild switch --flake ~/.nixosconf#legion"))

-- Screenshot
-- -- Screenshots
local satty = "satty -f - --initial-tool arrow --copy-command wl-copy --actions-on-escape save-to-clipboard,exit --early-exit"

hl.bind(mod .. " + Print",         hl.dsp.exec_cmd("grim -t ppm -g \"$(slurp -d)\" - | " .. satty))
hl.bind(mod .. " + SHIFT + Print", hl.dsp.exec_cmd("grim -t ppm - | " .. satty))

--------------------
---- LAYER RULES ----
--------------------

hl.layer_rule({
    name  = "wofi-blur",
    match = { namespace = "^(wofi)$" },
    blur  = true,
})

hl.layer_rule({
    name  = "notifications-blur",
    match = { namespace = "^(notifications)$" },
    blur  = true,
})

--------------------
---- WINDOW RULES ----
--------------------

hl.window_rule({
    name  = "suppress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "float-pavucontrol",
    match = { class = "^(pavucontrol)$" },
    float = true,
})

hl.window_rule({
    name  = "float-pip",
    match = { title = "^(Picture-in-Picture)$" },
    float = true,
    pin   = true,
})

hl.window_rule({
    name  = "satty-float",
    match = { class = "^(com.gabm.satty)$" },
    float = true,
})

hl.window_rule({
    name  = "kitty-opacity",
    match = { class = "^(kitty)$" },
    opacity = 0.92,
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

{ config, pkgs, colors, ... }:

let
  bg = "rgba(22, 25, 35, 0.88)";
  fg = "#${colors.base07}";
  accent = "#${colors.accent}";
  dim = "#${colors.comment}";
  green = "#${colors.green}";
  sky = "#${colors.sky}";
  lavender = "#${colors.lavender}";
  amber = "#${colors.amber}";
  red = "#${colors.red}";
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings = [
      {
        layer = "top";
        position = "top";
        exclusive = true;
        margin-top = 8;
        margin-left = 8;
        margin-right = 8;
        height = 34;

        modules-left = [
          "clock#icon"
          "clock#time"
          "clock#dateicon"
          "clock#date"
        ];

        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "custom/powerprofile"
          "backlight#icon"
          "backlight"
          "battery#icon"
          "battery"
          "pulseaudio#icon"
          "pulseaudio"
          "network"
          "tray"
          "custom/screenshot"
          "custom/power"
        ];

        "clock#icon" = {
          format = "󰥔";
          tooltip = false;
        };
        "clock#time" = {
          format = "{:%H:%M}";
          tooltip = false;
        };
        "clock#dateicon" = {
          format = "󰃰";
          tooltip = false;
        };
        "clock#date" = {
          format = "{:%a %d}";
          tooltip = true;
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "month";
            on-scroll = 1;
            format = {
              months = "<span color='#${colors.accent}'><b>{}</b></span>";
              days = "<span color='#${colors.base07}'>{}</span>";
              weekdays = "<span color='#${colors.green}'><b>{}</b></span>";
              today = "<span color='#${colors.accent}'><b><u>{}</u></b></span>";
            };
          };
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            active    = "●";
            persistent   = "◉";  # has windows — filled ring
            empty     = "○";  # no windows — empty ring
            urgent    = "⊙";
          };
          persistent-workspaces = {
            "*" = 10;
          };
        };

        "custom/powerprofile" = {
          exec = "powerprofilesctl get | sed 's/power-saver/󰌪/;s/balanced/󰗑/;s/performance/󱐋/'";
          interval = 2;
          format = "{}";
          tooltip = false;
          on-click = "sh -c 'cur=$(powerprofilesctl get); if [ \"$cur\" = \"power-saver\" ]; then powerprofilesctl set balanced; elif [ \"$cur\" = \"balanced\" ]; then powerprofilesctl set performance; else powerprofilesctl set power-saver; fi && notify-send \"Power\" \"$(powerprofilesctl get)\"'";
        };

        "backlight#icon" = {
          format = "{icon}";
          format-icons = ["󰋙" "󰫃" "󰫄" "󰫅" "󰫆" "󰫇" "󰫈"];
          tooltip = false;
        };
        
        backlight = {
          format = "{percent}%";
          tooltip = false;
          on-scroll-up = "brightnessctl set 5%+";
          on-scroll-down = "brightnessctl set 5%-";
        };

        "battery#icon" = {
          format = "{icon}";
          format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          format-charging = "󰂄";
          tooltip = false;
        };

        battery = {
          format = "{capacity}%";
          format-charging = "{capacity}%";
          states = {
            warning = 30;
            critical = 15;
          };
          tooltip = false;
        };

        "pulseaudio#icon" = {
          format = "{icon}";
          format-muted = "󰖁";
          format-icons = {
            default = ["󰕿" "󰖀" "󰕾"];
          };
          on-click = "pavucontrol";
          tooltip = false;
        };

        pulseaudio = {
          format = "{volume}%";
          format-muted = "muted";
          on-click = "pavucontrol";
          tooltip = false;
        };

        network = {
          format-wifi = "󰤨";
          format-disconnected = "󰤭";
          tooltip-format = "{essid} {signalStrength}%";
        };

        tray = {
          spacing = 6;
        };

        "custom/screenshot" = {
          format = "⛶";
          on-click = "grim -t ppm -g \"$(slurp -d)\" - | satty -f - --initial-tool arrow --copy-command wl-copy --actions-on-escape save-to-clipboard,exit --early-exit";
          tooltip = false;
        };

        "custom/power" = {
          format = "⏻";
          on-click = "systemctl poweroff";
          on-click-right = "systemctl reboot";
          tooltip-format = "Left: poweroff | Right: reboot";
        };
      }
    ];

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        border: none;
        border-radius: 0;
        min-height: 0;
        padding: 0;
        margin: 0;
      }

      window#waybar {
        background: transparent;
        color: ${fg};
      }

      .modules-left,
      .modules-center,
      .modules-right {
        background: transparent;
      }

      /* LEFT PILL — clock & date */
      #clock.icon {
        background: ${bg};
        color: ${accent};
        border-radius: 8px 0 0 8px;
        padding: 0 6px 0 14px;
        margin-top: 0;
      }

      #clock.time {
        background: ${bg};
        color: ${fg};
        padding: 0 8px 0 4px;
      }

      #clock.dateicon {
        background: ${bg};
        color: ${green};
        padding: 0 6px 0 8px;
      }

      #clock.date {
        background: ${bg};
        color: ${fg};
        border-radius: 0 8px 8px 0;
        padding: 0 14px 0 4px;
      }
      
      /* CENTER PILL — workspace */

      #workspaces {
        background: ${bg};
        border-radius: 8px;
        padding: 0 10px;
      }

      #workspaces button {
        background: transparent;
        color: ${dim};
        padding: 0 3px;
        min-width: 0;
        border-radius: 0;
        box-shadow: none;
        text-shadow: none;
      }

      #workspaces button.active {
        color: ${accent};
      }

      #workspaces button.urgent {
        color: ${red};
      }

      #workspaces button.empty {
        color: ${dim};
      }

      /* RIGHT PILL — system */
      #custom-powerprofile {
        background: ${bg};
        color: ${lavender};
        border-radius: 8px 0 0 8px;
        padding: 0 8px 0 14px;
      }

      #backlight.icon {
        background: ${bg};
        color: ${amber};
        padding: 0 4px 0 10px;
      }
      
      #backlight {
        background: ${bg};
        color: ${fg};
        padding: 0 6px 0 2px;
      }

      #battery.icon {
        background: ${bg};
        color: ${green};
        padding: 0 4px 0 10px;
      }

      #battery {
        background: ${bg};
        color: ${fg};
        padding: 0 6px 0 2px;
      }

      #battery.warning {
        color: ${amber};
      }

      #battery.critical {
        color: ${red};
      }

      #pulseaudio.icon {
        background: ${bg};
        color: ${sky};
        padding: 0 4px 0 10px;
      }

      #pulseaudio {
        background: ${bg};
        color: ${fg};
        padding: 0 6px 0 2px;
      }

      #pulseaudio.muted {
        color: ${dim};
      }

      #network {
        background: ${bg};
        color: ${green};
        padding: 0 10px;
      }

      #tray {
        background: ${bg};
        padding: 0 8px;
      }

      #custom-screenshot {
        background: ${bg};
        color: ${sky};
        padding: 0 8px 0 10px;
      }

      #custom-power {
        background: ${bg};
        color: ${red};
        border-radius: 0 8px 8px 0;
        padding: 0 14px 0 8px;
      }
    '';
  };
}

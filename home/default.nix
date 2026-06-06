{ config, pkgs, lib, ... }:

let
  colors = import ./colorscheme.nix;
in
{
  imports = [
    (import ./modules/zsh.nix { inherit config pkgs lib colors; })
    (import ./modules/hyprland.nix { inherit config pkgs lib colors; })
    (import ./modules/kitty.nix { inherit config pkgs lib colors; })
    (import ./modules/waybar.nix { inherit config pkgs lib colors; })
    (import ./modules/dunst.nix { inherit config pkgs lib colors; })
    (import ./modules/helix.nix { inherit config pkgs lib colors; })
    (import ./modules/wofi.nix { inherit config pkgs lib colors; })
    (import ./modules/gaming.nix { inherit config pkgs lib colors; })
    (import ./modules/emacs.nix { inherit config pkgs colors; })
  ];
  
  home.username = "abhi";
  home.homeDirectory = "/home/abhi";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;


  # Wallpaper Script
  home.file.".config/scripts/wallpaper-rotate.sh" = {
    text = ''
      #!/usr/bin/env bash
      WALLPAPER_DIR="$HOME/wallpapers"
      INTERVAL=1800
  
      while true; do
          wallpaper=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 1)
          if [ -n "$wallpaper" ]; then
              awww img "$wallpaper" \
                  --transition-type random \
                  --transition-duration 2 \
                  --transition-fps 60
          fi
          sleep "$INTERVAL"
      done
    '';
    executable = true;
  };

  # Battery Script
  home.file.".config/scripts/battery-monitor.sh" = {
    text = ''
      #!/usr/bin/env bash
      WARNING_SENT=false
      CRITICAL_SENT=false
  
      while true; do
        CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
        STATUS=$(cat /sys/class/power_supply/BAT0/status)
  
        if [ "$STATUS" = "Charging" ]; then
          WARNING_SENT=false
          CRITICAL_SENT=false
        elif [ "$CAPACITY" -le 10 ] && [ "$CRITICAL_SENT" = false ]; then
          notify-send -u critical -a "battery-monitor" -i battery-caution "Battery Critical" "Battery at ''${CAPACITY}%! Plug in now!" 
          CRITICAL_SENT=true
          WARNING_SENT=true
        elif [ "$CAPACITY" -le 20 ] && [ "$WARNING_SENT" = false ]; then
          notify-send -u normal -a "battery-monitor" -i battery-low "Battery Low" "Battery at ''${CAPACITY}%. Consider charging."
          WARNING_SENT=true
        fi
  
        sleep 60
      done
    '';
    executable = true;
  };

  home.packages = with pkgs; [
    zathura
    libnotify
    papirus-icon-theme

    #Media Codecs
    ffmpeg
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav

    #Editing
    #davinci-resolve

    #Game
    protonup-qt
    mangohud
    heroic
    bottles
    lutris
    prismlauncher
    zenity

    #work
    hubstaff
  ];
}

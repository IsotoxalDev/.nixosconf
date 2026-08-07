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
    (import ./modules/rofi.nix { inherit config pkgs colors; })
    (import ./modules/gaming.nix { inherit config pkgs lib colors; })
    ./modules/color-profiles.nix
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

  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--ozone-platform=wayland"
      "--enable-features=WebRtcPipeWireCapturer"
    ];
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name  = "Abhinav Kuruvila Joseph";
        email = "62714538+IsotoxalDev@users.noreply.github.com";
      };
    };
  };

  home.packages = with pkgs; [
    (pkgs.zathuraPkgs.zathuraWrapper.override {
      plugins = with pkgs.zathuraPkgs; [ zathura_pdf_mupdf ];
    })
    libnotify
    papirus-icon-theme
    motrix
    logseq
    godot
    mpv
    blender
    inkscape
    discord
    telegram-desktop
    calibre
    anki

    # AI Coding
    opencode
    claude-code

    #Media Codecs
    ffmpeg
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav

    #Editing
    davinci-resolve
    darktable
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
        wlrobs
      ];
    })
    kdePackages.kdenlive
    ardour
    audacity

    #Game
    (pkgs.symlinkJoin {
      name = "mesen";
      paths = [ pkgs.mesen ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/Mesen \
          --set GDK_BACKEND x11 \
          --set SDL_VIDEODRIVER x11 \
          --set DOTNET_EnableWriteXorExecute 0
      '';
    })
    protonup-qt
    mangohud
    heroic
    bottles
    lutris
    prismlauncher
    zenity

    #work
    hubstaff
    slack
    onlyoffice-desktopeditors

    # Archives
    unzip
    unrar

    # Bluetooth
    blueman
  ];
}

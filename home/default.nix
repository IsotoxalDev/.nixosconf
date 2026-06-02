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

  home.packages = with pkgs; [
    firefox
    helix
    zathura
    libnotify
  ];
}

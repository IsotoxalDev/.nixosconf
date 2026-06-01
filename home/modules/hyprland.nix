{ config, pkgs, lib, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    extraConfig = builtins.readFile ./hyprland.lua;
  };

  home.packages = with pkgs; [
    wofi
    dunst
    swaylock
    swayidle
    hyprpaper
    brightnessctl
    playerctl
    pavucontrol
    bibata-cursors
    hyprshot
  ];
}

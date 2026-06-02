{ config, pkgs, colors, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    extraConfig = ''
      -- colors injected by nix
      local c = {
        base      = "rgba(${colors.base01}ff)",
        surface   = "rgba(${colors.base02}ff)",
        overlay   = "rgba(${colors.base03}ff)",
        border    = "rgba(${colors.base05}ff)",
        fg        = "rgba(${colors.base07}ff)",
        accent    = "rgba(${colors.accent}ff)",
        accentDim = "rgba(${colors.accentDim}ff)",
        red       = "rgba(${colors.red}ff)",
        green     = "rgba(${colors.green}ff)",
        sky       = "rgba(${colors.sky}ff)",
        lavender  = "rgba(${colors.lavender}ff)",
        amber     = "rgba(${colors.amber}ff)",
        peach     = "rgba(${colors.peach}ff)",
        shadow    = "0xff${colors.base00}",
      }
    '' + builtins.readFile ./hyprland.lua;
  };

  home.packages = with pkgs; [
    wofi
    dunst
    swaylock
    waybar
    swayidle
    awww
    brightnessctl
    playerctl
    pavucontrol
    bibata-cursors
    grim
    slurp
    wl-clipboard
    satty
  ];
}

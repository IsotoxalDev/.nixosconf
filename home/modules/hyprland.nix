{ config, pkgs, colors, ... }:

let
  isFullscreen = pkgs.writeShellScript "is-fullscreen" ''
    hyprctl clients -j | grep -q '"fullscreen": [1-9]'
  '';
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    extraConfig = ''
      -- injected by nix
      local isFullscreen = "${isFullscreen}"
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

{ config, pkgs, lib, ... }:

let
  colors = import ./colorscheme.nix;
in
{
  imports = [
    (import ./modules/zsh.nix { inherit config pkgs lib colors; })
    (import ./modules/hyprland.nix { inherit config pkgs lib colors; })
  ];
  
  home.username = "abhi";
  home.homeDirectory = "/home/abhi";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    firefox
    helix
    zathura
    wofi
    waybar
    hyprpaper
  ];
}

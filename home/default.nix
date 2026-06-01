{ config, pkgs, ... }:

{
  imports = [
    ./modules/zsh.nix
    ./modules/hyprland.nix
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

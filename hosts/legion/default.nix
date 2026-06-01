{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/nvidia.nix
    ../../modules/hyprland.nix
    ../../modules/audio.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # btrfs compression
  boot.supportedFilesystems = [ "btrfs" ];

  # Networking
  networking.hostName = "legion";
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "Asia/Kolkata";

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";

  # Allow Unfree
  nixpkgs.config.allowUnfree = true;
  
  # User
  users.users.abhi = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.zsh;
  };

  # Enable zsh
  programs.zsh.enable = true;

  # Basic packages
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    pciutils
    usbutils
    kitty
    waybar
    wofi
    hyprpaper
  ];

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Firmware
  hardware.enableRedistributableFirmware = true;

  system.stateVersion = "26.05";
}

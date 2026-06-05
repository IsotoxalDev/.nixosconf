{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/nvidia.nix
    ../../modules/hyprland.nix
    ../../modules/audio.nix
    ../../modules/battery.nix
    ../../modules/legion.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  # btrfs compression
  boot.supportedFilesystems = [ "btrfs" ];

  # Networking
  networking.hostName = "legion";
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "Asia/Kolkata";

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";

  # xdg-portal
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

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

  # Steam + gaming
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.gamemode.enable = true;

  # Firefox
  programs.firefox = {
    enable = true;
    preferences = {
      "media.ffmpeg.vaapi.enabled" = true;
      "media.hardware-video-decoding.force-enabled" = true;
      "layout.css.devPixelsPerPx" = "1.25";
    };
  };

  # Ollama
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };

  # Basic packages
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    pciutils
    usbutils
    kitty
    sbctl
  ];

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
    STEAM_FORCE_DESKTOPUI_SCALING = "1.6";
  };

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Firmware
  hardware.enableRedistributableFirmware = true;

  system.stateVersion = "26.05";
}

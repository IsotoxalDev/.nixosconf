{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/nvidia.nix
    ../../modules/hyprland.nix
    ../../modules/audio.nix
    ../../modules/battery.nix
    ../../modules/legion.nix
    ../../modules/gamepad.nix
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
  networking.firewall.allowedTCPPorts = [ 4455 3000 ]; # OBS WebSocket (IRL Pro), 3000 (dev server)

  # Syncthing
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "abhi";
    dataDir = "/home/abhi";
  };

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
  nixpkgs.config.allowInsecurePredicate = _: true;


  # User
  users.users.abhi = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "input" "dialout" ];
    shell = pkgs.zsh;
  };

  # Dynamic linking libraries
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      fuse3
      icu
      nss
      openssl
      curl
      expat


      pkgsi686Linux.stdenv.cc.cc
      pkgsi686Linux.zlib
    ];
  };

  # 32-bit dynamic linker for Wine/Proton (nix-ld only creates the 64-bit stub)
  systemd.tmpfiles.rules = [
    "L+ /lib/ld-linux.so.2 - - - - ${pkgs.pkgsi686Linux.glibc}/lib/ld-linux.so.2"
  ];

  # Enable zsh
  programs.zsh.enable = true;

  # Steam + gaming
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    extraPackages = with pkgs; [ gamemode ];
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

  # MySQL
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
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
    pkgsi686Linux.glibc
  ];

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
    STEAM_FORCE_DESKTOPUI_SCALING = "1.6";
    NIXOS_OZONE_WL = "1";
  };

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
  ];

  # FPGA udev rules (Quartus/ModelSim)
  services.udev.packages = [ inputs.nix-fpga.packages.x86_64-linux.quartus-udev-rules ];

  # Removable drives
  services.udisks2.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Firmware
  hardware.enableRedistributableFirmware = true;

  system.stateVersion = "26.05";
}

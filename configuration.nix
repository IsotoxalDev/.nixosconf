{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

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

  # NVIDIA
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:2:0:0";
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  # for Wayland + NVIDIA
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fhdev=1"
  ];

  # Hyprland + NVIDIA
  hardware.graphics.enable = true;

  # Environment variables for NVIDIA
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    _GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Login Manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
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
    firefox
  ];

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Sound via pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Firmware
  hardware.enableRedistributableFirmware = true;

  system.stateVersion = "26.05";
}

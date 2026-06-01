{ config, pkgs, lib, ... }:

{
  # LenovoLegionLinux kernel module
  boot.extraModulePackages = [
    pkgs.linuxPackages_latest.lenovo-legion-module
  ];
  boot.kernelModules = [ "lenovo_legion" ];
  boot.kernelParams = [
    "lenovo_legion.force=1"
  ];

  # Expose legion sysfs to user
  services.udev.extraRules = ''
    SUBSYSTEM=="platform", DRIVER=="lenovo-legion", RUN+="${pkgs.coreutils}/bin/chmod -R a+rw /sys/bus/platform/drivers/lenovo-legion/"
  '';

  environment.systemPackages = with pkgs; [
    lenovo-legion
  ];
}

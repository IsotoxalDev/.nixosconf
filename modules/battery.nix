{ config, pkgs, ... }:

{
  # power-profiles-daemon manages platform_profile (quiet/balanced/performance)
  services.power-profiles-daemon.enable = true;

  # Battery charge threshold via ideapad_laptop (already working)
  # conservation_mode is handled by the ideapad_acpi driver automatically
  # TLP is disabled as it conflicts with power-profiles-daemon

  # Set charge threshold on boot via udev
  services.udev.extraRules = ''
    SUBSYSTEM=="platform", DRIVER=="ideapad_acpi", \
    RUN+="${pkgs.bash}/bin/bash -c 'echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode'"
  '';
}

{ config, lib, pkgs, ... }:

let
  notifyConnected = pkgs.writeShellScript "8bitdo-connected" ''
    /run/wrappers/bin/su abhi -s ${pkgs.bash}/bin/sh -c \
      "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus \
       XDG_RUNTIME_DIR=/run/user/1000 \
       ${pkgs.libnotify}/bin/notify-send \
         -a gamepad -u low -i input-gaming \
         '8BitDo Ultimate 2' 'Controller connected'"
  '';

  notifyDisconnected = pkgs.writeShellScript "8bitdo-disconnected" ''
    /run/wrappers/bin/su abhi -s ${pkgs.bash}/bin/sh -c \
      "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus \
       XDG_RUNTIME_DIR=/run/user/1000 \
       ${pkgs.libnotify}/bin/notify-send \
         -a gamepad -u low -i input-gaming \
         '8BitDo Ultimate 2' 'Controller disconnected'"
  '';
in
{
  hardware.xpadneo.enable = true;
  services.upower.enable = true;

  services.udev.extraRules = ''
    # 8BitDo Ultimate 2 - HID access (for firmware tool)
    SUBSYSTEM=="hidraw", ATTRS{idProduct}=="310b", ATTRS{idVendor}=="2dc8", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idProduct}=="310b", ATTRS{idVendor}=="2dc8", TAG+="uaccess"

    # Bootloader mode - run: lsusb | grep 2dc8 while holding Pair+USB to find real ID
    SUBSYSTEM=="hidraw", ATTRS{idProduct}=="3209", ATTRS{idVendor}=="2dc8", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idProduct}=="3209", ATTRS{idVendor}=="2dc8", TAG+="uaccess"

    # Dongle connect/disconnect notifications
    ACTION=="add", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="2dc8", ATTRS{idProduct}=="310b", RUN+="${notifyConnected}"
    ACTION=="remove", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ENV{ID_VENDOR_ID}=="2dc8", ENV{ID_MODEL_ID}=="310b", RUN+="${notifyDisconnected}"
  '';
}

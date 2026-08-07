{ config, pkgs, lib, colors, ... }:

let
  gamepadBatteryMonitor = pkgs.writeShellScript "gamepad-battery-monitor" ''
    PREV=""
    while true; do
      BATTERY=$(${pkgs.upower}/bin/upower -e 2>/dev/null | grep -i "8bitdo\|2dc8\|gamepad")
      if [ -n "$BATTERY" ]; then
        LEVEL=$(${pkgs.upower}/bin/upower -i "$BATTERY" 2>/dev/null \
          | grep "percentage" | grep -oP '\d+' | head -1)
        if [ -n "$LEVEL" ]; then
          if [ "$LEVEL" -le 10 ] && [ "$PREV" != "critical" ]; then
            ${pkgs.libnotify}/bin/notify-send \
              -a gamepad-battery -u critical -i battery-caution \
              "8BitDo Ultimate 2" "Battery critical: ''${LEVEL}%! Charge now!"
            PREV="critical"
          elif [ "$LEVEL" -le 25 ] && [ "$PREV" != "warning" ]; then
            ${pkgs.libnotify}/bin/notify-send \
              -a gamepad-battery -u normal -i battery-low \
              "8BitDo Ultimate 2" "Battery low: ''${LEVEL}%"
            PREV="warning"
          elif [ "$LEVEL" -gt 25 ]; then
            PREV=""
          fi
        fi
      fi
      sleep 300
    done
  '';
in
{
  systemd.user.services.gamepad-battery-monitor = {
    Unit = {
      Description = "8BitDo Controller Battery Monitor";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${gamepadBatteryMonitor}";
      Restart = "on-failure";
      RestartSec = "30s";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  home.packages = with pkgs; [
    # Wine for 8BitDo firmware updater (run: wine 8BitDoToolkit.exe)
    # After first run: wine regedit → HKLM\System\CurrentControlSet\Services\winebus
    #   add DWORD "Enable SDL" = 0, then: wineserver -k
    wineWow64Packages.full
    winetricks
    cabextract
    godot_4
  ];

  programs.mangohud = {
    enable = true;
    settings = {
      legacy_layout = false;
      gpu_stats = true;
      gpu_temp = true;
      gpu_power = true;
      gpu_core_clock = true;
      gpu_mem_clock = true;
      cpu_stats = true;
      cpu_temp = true;
      cpu_power = true;
      cpu_mhz = true;
      ram = true;
      fps = true;
      frametime = true;
      hud_no_margin = true;
      table_columns = 3;
      font_size = 20;
      background_alpha = 0.4;
      position = "top-left";
      toggle_hud = "Shift_R+F12";

      # Isotoxal colors
      gpu_color = "C5D86D";
      cpu_color = "78b8d0";
      ram_color = "b8a9e3";
      fps_color_change = true;
      fps_value = "30,60";
      fps_color = "e57c7c,d4a96a,8fd4a8";
      text_color = "dde1e6";
      background_color = "0f111a";
    };
  };
}

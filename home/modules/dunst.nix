{ config, pkgs, colors, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        width = 350;
        height = 200;
        origin = "top-right";
        offset = "12x52";
        scale = 0;
        notification_limit = 5;
        icon_theme = "Papirus-Dark";

        progress_bar = true;
        progress_bar_height = 8;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;

        indicate_hidden = true;
        transparency = 15;
        separator_height = 2;
        padding = 12;
        horizontal_padding = 14;
        text_icon_padding = 12;
        frame_width = 1;
        frame_color = "#${colors.base05}";
        gap_size = 6;
        separator_color = "frame";
        sort = true;

        font = "JetBrainsMono Nerd Font 11";
        line_height = 4;
        markup = "full";
        format = "<b>%s</b>\\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = false;
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = true;

        enable_recursive_icon_lookup = true;
        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 48;

        sticky_history = true;
        history_length = 20;

        browser = "firefox";
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";

        corner_radius = 8;
        ignore_dbusclose = false;
        force_xwayland = false;
        force_xinerama = false;

        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };

      urgency_low = {
        background = "#${colors.base02}";
        foreground = "#${colors.base06}";
        frame_color = "#${colors.base05}";
        timeout = 4;
      };

      urgency_normal = {
        background = "#${colors.base02}";
        foreground = "#${colors.base07}";
        frame_color = "#${colors.accent}";
        timeout = 6;
      };

      urgency_critical = {
        background = "#${colors.base02}";
        foreground = "#${colors.red}";
        frame_color = "#${colors.red}";
        timeout = 0;
      };

      z_battery_warning = {
        appname = "battery-monitor";
        urgency = "normal";
        background = "#${colors.base03}";
        foreground = "#${colors.amber}";
        frame_color = "#${colors.amber}";
        timeout = 0;
      };
      
      z_battery_critical = {
        appname = "battery-monitor";
        urgency = "critical";
        background = "#${colors.base03}";
        foreground = "#${colors.red}";
        frame_color = "#${colors.red}";
        timeout = 0;
      };

      z_gamepad = {
        appname = "gamepad";
        background = "#${colors.base03}";
        foreground = "#${colors.green}";
        frame_color = "#${colors.sky}";
        timeout = 4;
      };

      z_gamepad_battery = {
        appname = "gamepad-battery";
        background = "#${colors.base03}";
        foreground = "#${colors.amber}";
        frame_color = "#${colors.amber}";
        timeout = 0;
      };
    };
  };
}

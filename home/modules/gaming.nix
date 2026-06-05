{ config, pkgs, colors, ... }:

{
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

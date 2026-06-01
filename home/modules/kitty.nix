{ config, pkgs, colors, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      # Colors from Isotoxal
      background            = "#${colors.base01}";
      foreground            = "#${colors.base07}";
      selection_background  = "#${colors.base04}";
      selection_foreground  = "#${colors.base07}";
      cursor                = "#${colors.accent}";
      cursor_text_color     = "#${colors.base01}";
      url_color             = "#${colors.sky}";

      # Black
      color0  = "#${colors.base00}";
      color8  = "#${colors.base05}";
      # Red
      color1  = "#${colors.red}";
      color9  = "#${colors.red}";
      # Green
      color2  = "#${colors.accent}";
      color10 = "#${colors.accentDim}";
      # Yellow
      color3  = "#${colors.amber}";
      color11 = "#${colors.amber}";
      # Blue
      color4  = "#${colors.sky}";
      color12 = "#${colors.sky}";
      # Magenta
      color5  = "#${colors.lavender}";
      color13 = "#${colors.lavender}";
      # Cyan
      color6  = "#${colors.sky}";
      color14 = "#${colors.sky}";
      # White
      color7  = "#${colors.base07}";
      color15 = "#${colors.base07}";

      # Font
      font_family      = "JetBrainsMono Nerd Font";
      bold_font        = "JetBrainsMono Nerd Font Bold";
      italic_font      = "JetBrainsMono Nerd Font Italic";
      font_size        = "13.0";

      # Appearance
      window_padding_width    = 4;
      background_opacity      = "0.70";
      dynamic_background_color = "yes";
      cursor_shape            = "beam";
      cursor_blink_interval   = "0";

      # Performance
      repaint_delay  = 8;
      input_delay    = 2;
      sync_to_monitor = "yes";

      # Misc
      enable_audio_bell = "no";
      confirm_os_window_close = 0;
      scrollback_lines = 10000;
    };
  };

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}

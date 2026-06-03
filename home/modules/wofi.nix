{ config, pkgs, colors, ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      width = 400;
      height = 500;
      location = "center";
      show = "drun";
      prompt = "Search";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 48;
      gtk_dark = true;
      dynamic_lines = false;
      hide_scroll = true;
      matching = "fuzzy";
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        border: none;
        border-radius: 0;
      }

      window {
        background-color: rgba(15, 17, 26, 0.75);
        border: 1px solid #${colors.base05};
        border-radius: 8px;
      }

      #input {
        background-color: rgba(22, 25, 35, 0.60);
        color: #${colors.base07};
        border: none;
        border-bottom: 1px solid #${colors.base05};
        border-radius: 8px 8px 0 0;
        padding: 14px 16px;
        margin: 0;
        outline: none;
      }

      #input:focus {
        border-bottom-color: #${colors.accent};
      }

      #inner-box {
        background-color: transparent;
        margin: 0;
        padding: 4px;
      }

      #outer-box {
        background-color: transparent;
        padding: 0;
      }

      #scroll {
        background-color: transparent;
        margin: 0;
        padding: 0;
      }

      #text {
        color: #${colors.base07};
        padding: 0 4px;
      }

      #entry {
        background-color: transparent;
        border-radius: 0;
        padding: 10px 12px;
        margin: 0;
      }

      #entry:selected {
        background-color: rgba(30, 33, 48, 0.80);
      }

      #entry:selected #text {
        color: #${colors.accent};
      }

      #entry:selected #img {
        margin-right: 12px;
      }

      #img {
        margin-right: 12px;
      }
    '';
  };
}

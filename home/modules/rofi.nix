{ config, pkgs, colors, ... }:

let
  rofiTheme = builtins.toFile "rofi-theme.rasi" ''
    * {
        bg: rgba(15, 17, 26, 0.85);
        fg: #${colors.base07};
        ac: #${colors.accent};
        al: rgba(0,0,0,0);
        se: rgba(30, 33, 48, 0.90);
    }

    window {
        transparency:     "real";
        background-color: @bg;
        text-color:       @fg;
        border:           2px solid;
        border-color:     @ac;
        border-radius:    0px;
        height:           50%;
        width:            20%;
        location:         center;
        x-offset:         0;
        y-offset:         0;
    }

    prompt {
        enabled:          true;
        padding:          0.30% 1% 0% -0.5%;
        background-color: @al;
        text-color:       @fg;
    }

    entry {
        background-color:  @al;
        text-color:        @fg;
        placeholder-color: @fg;
        expand:            true;
        horizontal-align:  0;
        placeholder:       "Search";
        padding:           0.10% 0% 0% 0%;
        blink:             true;
    }

    inputbar {
        children:         [ prompt, entry ];
        background-color: @bg;
        text-color:       @fg;
        expand:           false;
        border:           0%;
        border-radius:    0px;
        border-color:     @bg;
        margin:           0%;
        padding:          1.5%;
    }

    listview {
        background-color: @al;
        padding:          0px;
        columns:          1;
        lines:            5;
        spacing:          0%;
        cycle:            false;
        dynamic:          true;
        layout:           vertical;
    }

    mainbox {
        background-color: @al;
        border:           0%;
        border-radius:    0%;
        border-color:     @ac;
        children:         [ inputbar, listview ];
        spacing:          0%;
        padding:          0%;
    }

    element {
        background-color: @al;
        text-color:       @fg;
        orientation:      vertical;
        border-radius:    0%;
        padding:          1% 0.5% 1% 0.5%;
    }

    element-icon {
        background-color: inherit;
        text-color:       inherit;
        horizontal-align: 0.5;
        vertical-align:   0.5;
        size:             50px;
        border:           0px;
    }

    element-text {
        background-color: @al;
        text-color:       inherit;
        expand:           true;
        horizontal-align: 0.5;
        vertical-align:   0.5;
        margin:           0.25% 0.25% 0% 0.25%;
    }

    element selected {
        background-color: @se;
        text-color:       @fg;
        border:           0%;
        border-radius:    0px;
        border-color:     @bg;
    }
  '';
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    terminal = "kitty";
    theme = rofiTheme;
    extraConfig = {
      modi = "drun";
      show-icons = true;
      icon-theme = "Papirus";
      display-drun = "";
      drun-display-format = "{name}";
      disable-history = false;
      sidebar-mode = false;
      sort = true;
      sorting-method = "fzf";
    };
  };
}

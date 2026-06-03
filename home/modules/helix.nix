{ config, pkgs, colors, ... }:

{
  programs.helix = {
    enable = true;

    settings = {
      theme = "isotoxal";
      editor = {
        line-number = "relative";
        true-color = true;
        mouse = false;
        middle-click-paste = false;
        shell = ["zsh"];
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        whitespace.render = {
          newline = "all";
          tab = "all";
        };
        indent-guides = {
          render = true;
          character = "╎";
        };
        statusline = {
          left = ["mode" "spinner" "file-name" "file-modification-indicator"];
          center = ["file-type"];
          right = ["diagnostics" "selections" "position" "file-encoding"];
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        auto-save = true;
        completion-trigger-len = 1;
        rulers = [80 120];
      };
      keys.normal = {
        space.space = "file_picker";
        space.e = "file_picker_in_current_directory";
        space.b = "buffer_picker";
        space.d = "diagnostics_picker";
        "C-s" = ":w";
      };
      keys.insert = {
        "C-s" = ["normal_mode" ":w"];
      };
    };

    themes = {
      isotoxal = {
        "ui.background" = { bg = "base01"; };
        "ui.background.separator" = { fg = "base05"; };
        "ui.text" = { fg = "base07"; };
        "ui.text.focus" = { fg = "base07"; modifiers = ["bold"]; };
        "ui.cursor" = { fg = "base01"; bg = "accent"; };
        "ui.cursor.insert" = { fg = "base01"; bg = "sky"; };
        "ui.cursor.select" = { fg = "base01"; bg = "lavender"; };
        "ui.cursor.match" = { fg = "base01"; bg = "amber"; };
        "ui.cursor.primary" = { fg = "base01"; bg = "accent"; };
        "ui.selection" = { bg = "base04"; };
        "ui.selection.primary" = { bg = "base04"; };
        "ui.linenr" = { fg = "comment"; };
        "ui.linenr.selected" = { fg = "accent"; modifiers = ["bold"]; };
        "ui.statusline" = { fg = "base06"; bg = "base02"; };
        "ui.statusline.normal" = { fg = "base01"; bg = "accent"; modifiers = ["bold"]; };
        "ui.statusline.insert" = { fg = "base01"; bg = "sky"; modifiers = ["bold"]; };
        "ui.statusline.select" = { fg = "base01"; bg = "lavender"; modifiers = ["bold"]; };
        "ui.statusline.separator" = { fg = "base05"; };
        "ui.popup" = { bg = "base02"; };
        "ui.popup.info" = { bg = "base02"; };
        "ui.window" = { fg = "base05"; };
        "ui.help" = { fg = "base07"; bg = "base02"; };
        "ui.menu" = { fg = "base07"; bg = "base02"; };
        "ui.menu.selected" = { fg = "base01"; bg = "accent"; };
        "ui.menu.scroll" = { fg = "accent"; bg = "base03"; };
        "ui.virtual.indent-guide" = { fg = "base04"; };
        "ui.virtual.inlay-hint" = { fg = "comment"; };
        "ui.virtual.ruler" = { bg = "base02"; };
        "ui.virtual.whitespace" = { fg = "base04"; };
        "ui.highlight" = { bg = "base03"; };
        "ui.gutter" = { bg = "base01"; };
        "ui.gutter.selected" = { bg = "base02"; };

        # Syntax
        "keyword" = { fg = "red"; };
        "keyword.control" = { fg = "red"; };
        "keyword.control.return" = { fg = "red"; modifiers = ["bold"]; };
        "keyword.operator" = { fg = "red"; };
        "keyword.directive" = { fg = "red"; };
        "keyword.function" = { fg = "red"; };
        "operator" = { fg = "accentDim"; };
        "punctuation" = { fg = "base06"; };
        "punctuation.delimiter" = { fg = "base06"; };
        "punctuation.bracket" = { fg = "base06"; };
        "variable" = { fg = "base07"; };
        "variable.builtin" = { fg = "red"; };
        "variable.parameter" = { fg = "base07"; modifiers = ["italic"]; };
        "variable.other.member" = { fg = "base07"; };
        "type" = { fg = "lavender"; };
        "type.builtin" = { fg = "lavender"; modifiers = ["bold"]; };
        "constructor" = { fg = "lavender"; };
        "function" = { fg = "sky"; };
        "function.builtin" = { fg = "sky"; modifiers = ["bold"]; };
        "function.macro" = { fg = "peach"; };
        "function.method" = { fg = "sky"; };
        "tag" = { fg = "red"; };
        "attribute" = { fg = "amber"; };
        "namespace" = { fg = "lavender"; modifiers = ["italic"]; };
        "string" = { fg = "green"; };
        "string.regexp" = { fg = "peach"; };
        "string.special" = { fg = "peach"; };
        "string.special.path" = { fg = "green"; };
        "constant" = { fg = "amber"; };
        "constant.builtin" = { fg = "amber"; modifiers = ["bold"]; };
        "constant.character" = { fg = "green"; };
        "constant.numeric" = { fg = "base07"; };
        "comment" = { fg = "comment"; modifiers = ["italic"]; };
        "comment.block.documentation" = { fg = "comment"; modifiers = ["italic"]; };
        "label" = { fg = "accent"; };
        "special" = { fg = "accent"; };

        # Diagnostics
        "diagnostic.error" = { underline = { color = "red"; style = "curl"; }; };
        "diagnostic.warning" = { underline = { color = "amber"; style = "curl"; }; };
        "diagnostic.info" = { underline = { color = "sky"; style = "curl"; }; };
        "diagnostic.hint" = { underline = { color = "green"; style = "curl"; }; };
        "error" = { fg = "red"; };
        "warning" = { fg = "amber"; };
        "info" = { fg = "sky"; };
        "hint" = { fg = "green"; };

        # Diff
        "diff.plus" = { fg = "green"; };
        "diff.minus" = { fg = "red"; };
        "diff.delta" = { fg = "amber"; };

        # Markup
        "markup.heading" = { fg = "accent"; modifiers = ["bold"]; };
        "markup.bold" = { modifiers = ["bold"]; };
        "markup.italic" = { modifiers = ["italic"]; };
        "markup.link.url" = { fg = "sky"; modifiers = ["underlined"]; };
        "markup.link.text" = { fg = "green"; };
        "markup.raw" = { fg = "peach"; };
        "markup.quote" = { fg = "comment"; modifiers = ["italic"]; };

        palette = {
          base00 = "#0f111a";
          base01 = "#0f111a";
          base02 = "#161923";
          base03 = "#1e2130";
          base04 = "#272b3c";
          base05 = "#383c4e";
          base06 = "#b8bec6";
          base07 = "#dde1e6";
          accent    = "#C5D86D";
          accentDim = "#9db85a";
          red       = "#e57c7c";
          green     = "#8fd4a8";
          sky       = "#78b8d0";
          lavender  = "#b8a9e3";
          amber     = "#d4a96a";
          peach     = "#c9857a";
          comment   = "#4a5060";
        };
      };
    };

    extraPackages = with pkgs; [
      # Rust
      rust-analyzer
      # Web
      svelte-language-server
      typescript-language-server
      vscode-langservers-extracted
      # Nix
      nil
      nixpkgs-fmt
      # Lua
      lua-language-server
      # GDScript (Godot)
      gdtoolkit_4
    ];
  };
}

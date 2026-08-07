{ config, pkgs, lib, colors, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza --icons";
      ll = "eza -l --icons";
      la = "eza -la --icons";
      lt = "eza --tree --icons";
      cat = "bat";
      cd = "z";
      rebuild = "sudo nixos-rebuild switch --flake ~/.nixosconf#legion";
      update = "nix flake update --flake ~/.nixosconf/flake.nix && rebuild";
    };

    history.size = 10000;

    initContent = ''
      eval "$(zoxide init zsh)"
      export PATH="$HOME/.local/bin:$PATH"
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = lib.concatStrings [
        "$custom"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$cmd_duration"
        "$line_break"
        "$python"
        "$character"
      ];
      directory.style = "blue";
      character = {
        success_symbol = "[❯](green)";
        error_symbol = "[❯](red)";
      };
      git_branch = {
        format = "[$branch]($style)";
        style = "bright-black";
      };
      git_status = {
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
        style = "cyan";
        conflicted = "";
        untracked = "";
        modified = "";
        staged = "";
        renamed = "";
        deleted = "";
        stashed = "≡";
      };
      git_state = {
        format = "\([$state( $progress_current/$progress_total)]($style)\) ";
        style = "bright-black";
      };
      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };
      python = {
        format = "[$virtualenv]($style) ";
        style = "bright-black";
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "never";
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    keymap = {
      manager.prepend_keymap = [
        {
          on = [ "m" ];
          run = "shell 'udisksctl mount -b \"$1\"' --confirm";
          desc = "Mount selected drive";
        }
        {
          on = [ "M" ];
          run = "shell 'udisksctl unmount -b \"$1\"' --confirm";
          desc = "Unmount selected drive";
        }
      ];
    };
  };

  home.packages = with pkgs; [
    eza
    bat
    ripgrep
    fd
    bottom
  ];
}

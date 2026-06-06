{ config, pkgs, colors, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;  # pure GTK, best for Wayland
    extraPackages = epkgs: with epkgs; [
      # Evil (modal editing)
      evil
      evil-collection
      evil-surround
      general  # keybinding manager

      # UI
      doom-themes
      doom-modeline
      all-the-icons
      olivetti  # distraction-free writing
      mixed-pitch  # proportional fonts in prose

      # Org + second brain
      org
      org-roam
      org-modern

      # Fountain (screenplay)
      fountain-mode

      # Completion
      vertico
      consult
      orderless
      marginalia
      embark
      embark-consult

      # Coding
      lsp-mode
      lsp-ui
      treesit-auto
      company
      flycheck

      # Nix
      nix-mode

      # Misc
      magit
      which-key
      helpful
      visual-fill-column
    ];
  };

  home.file.".emacs.d/init.el".text = ''
    ;; Isotoxal Emacs Config

    ;; Performance
    (setq gc-cons-threshold 100000000)
    (setq read-process-output-max (* 1024 1024))

    ;; Clean UI
    (setq inhibit-startup-message t)
    (scroll-bar-mode -1)
    (tool-bar-mode -1)
    (tooltip-mode -1)
    (menu-bar-mode -1)
    (set-fringe-mode 8)

    ;; Font
    (set-face-attribute 'default nil
      :font "JetBrainsMono Nerd Font"
      :height 130)
    (set-face-attribute 'variable-pitch nil
      :font "Noto Sans"
      :height 140)

    ;; Line numbers
    (global-display-line-numbers-mode t)
    (setq display-line-numbers-type 'relative)
    (dolist (mode '(org-mode-hook
                    fountain-mode-hook
                    term-mode-hook))
      (add-hook mode (lambda () (display-line-numbers-mode 0))))

    ;; Package system
    (require 'package)
    (setq package-archives nil)  ;; home-manager manages packages

    ;; Evil mode
    (require 'evil)
    (require 'evil-collection)
    (setq evil-want-integration t)
    (setq evil-want-keybinding nil)
    (setq evil-want-C-u-scroll t)
    (setq evil-undo-system 'undo-redo)
    (evil-mode 1)
    (evil-collection-init)

    (require 'evil-surround)
    (global-evil-surround-mode 1)

    ;; General keybindings (Space leader like helix)
    (require 'general)
    (general-evil-setup t)
    (general-create-definer isotoxal/leader
      :keymaps '(normal visual emacs)
      :prefix "SPC"
      :global-prefix "C-SPC")

    (isotoxal/leader
      "f"  '(:ignore t :which-key "files")
      "ff" '(find-file :which-key "find file")
      "fr" '(consult-recent-file :which-key "recent files")
      "b"  '(:ignore t :which-key "buffers")
      "bb" '(consult-buffer :which-key "switch buffer")
      "bk" '(kill-this-buffer :which-key "kill buffer")
      "w"  '(:ignore t :which-key "windows")
      "wv" '(split-window-right :which-key "split right")
      "ws" '(split-window-below :which-key "split below")
      "wk" '(delete-window :which-key "close window")
      "n"  '(:ignore t :which-key "notes")
      "nn" '(org-roam-node-find :which-key "find note")
      "ni" '(org-roam-node-insert :which-key "insert link")
      "nc" '(org-roam-capture :which-key "capture note")
      "g"  '(:ignore t :which-key "git")
      "gg" '(magit-status :which-key "magit")
      "q"  '(:ignore t :which-key "quit")
      "qq" '(save-buffers-kill-emacs :which-key "quit emacs"))

    ;; Which key
    (require 'which-key)
    (which-key-mode)
    (setq which-key-idle-delay 0.3)

    ;; Vertico (completion UI)
    (require 'vertico)
    (vertico-mode)
    (require 'orderless)
    (setq completion-styles '(orderless basic))
    (require 'marginalia)
    (marginalia-mode)

    ;; Doom theme
    (require 'doom-themes)
    (load-theme 'doom-one t)
    (require 'doom-modeline)
    (doom-modeline-mode 1)

    ;; Olivetti (distraction-free)
    (setq olivetti-body-width 80)

    ;; Fountain mode
    (require 'fountain-mode)
    (add-hook 'fountain-mode-hook
      (lambda ()
        (olivetti-mode 1)
        (mixed-pitch-mode 1)
        (flyspell-mode 1)
        (visual-line-mode 1)
        (display-line-numbers-mode 0)))

    ;; Org mode
    (require 'org-modern)
    (global-org-modern-mode)
    (add-hook 'org-mode-hook
      (lambda ()
        (olivetti-mode 1)
        (mixed-pitch-mode 1)
        (visual-line-mode 1)))

    ;; Org-roam
    (require 'org-roam)
    (setq org-roam-directory "~/Notes")
    (org-roam-db-autosync-mode)

    ;; LSP
    (require 'lsp-mode)
    (setq lsp-keymap-prefix "SPC l")
    (add-hook 'prog-mode-hook #'lsp-deferred)

    ;; Treesitter
    (require 'treesit-auto)
    (global-treesit-auto-mode)

    ;; Company (completion)
    (require 'company)
    (global-company-mode)

    ;; Nix
    (require 'nix-mode)
    (add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))

    ;; Magit
    (require 'magit)
  '';
}

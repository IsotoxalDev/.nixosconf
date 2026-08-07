{ pkgs, ... }:

{
  home.file.".local/bin/switch-color-profile" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      PROFILES_DIR="$HOME/.colors"
      STATE_FILE="$HOME/.local/state/color-profile-index"
      PROFILES=(sRGB DisplayP3 DCIP3 Default AdobeRGB REC709 Native)

      mkdir -p "$(dirname "$STATE_FILE")"
      CURRENT=$(cat "$STATE_FILE" 2>/dev/null || echo "-1")
      NEXT=$(( (CURRENT + 1) % ''${#PROFILES[@]} ))
      echo "$NEXT" > "$STATE_FILE"

      ICC="$PROFILES_DIR/TPLCD_420B_''${PROFILES[$NEXT]}.icm"
      hyprctl eval "hl.monitor({ output = \"eDP-1\", mode = \"preferred\", position = \"auto\", scale = 1.6, icc = \"$ICC\" })" -q
      notify-send "Color Profile" "''${PROFILES[$NEXT]}"
    '';
  };
}

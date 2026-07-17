{ config, lib, pkgs, ... }:

{
  imports = [
    ./programs
    ./desktop
  ];

  home.username = "jashton";
  home.homeDirectory = "/home/jashton";
  home.file.".zshrc".text = ''
    # Zsh is configured globally at the NixOS system level.
    # This file exists solely to prevent the zsh-newuser-install prompt.
  '';
  
  home.sessionVariables = {
    WINIT_X11_SCALE_FACTOR = "1.0";
  };

  home.packages = with pkgs; [
    aider-chat
    animdl
    asciinema
    claude-code
    discord
    freetube
    intelli-shell
    jrnl
    keepass
    mc
    spotify

    (pkgs.writeShellScriptBin "lock-screen" ''
      # Color palette mapped to i3lock-color format (RRGGBBAA)
      BLANK="00000000"       # Fully transparent
      BLACK="1e1f21ff"       # Carbon Black
      GRAPE="4f3963ff"       # Vintage Grape (Main Ring)
      VIOLET="2c2137ff"      # Midnight Violet (Verifying Ring)
      LAVENDER1="8d739cff"   # Vintage Lavender 1 (Text)
      LAVENDER2="7e6790ff"   # Vintage Lavender 2 (Backspace Highlight)
      LAVENDER3="847397ff"   # Vintage Lavender 3 (Keypress Highlight)

      ${pkgs.i3lock-color}/bin/i3lock-color \
        --image="${./desktop/assets/blurred-samuraii.jpg}" \
        --fill \
        -c "1E1F21" \
        \
        --insidever-color=$BLANK \
        --ringver-color=$VIOLET \
        \
        --insidewrong-color=$BLANK \
        --ringwrong-color=$GRAPE \
        \
        --inside-color=$BLANK \
        --ring-color=$GRAPE \
        --line-color=$BLANK \
        --separator-color=$BLANK \
        \
        --verif-color=$LAVENDER1 \
        --wrong-color=$LAVENDER1 \
        --time-color=$LAVENDER1 \
        --date-color=$LAVENDER1 \
        --layout-color=$LAVENDER1 \
        --keyhl-color=$LAVENDER3 \
        --bshl-color=$LAVENDER2 \
        \
        --clock \
        --indicator \
        --time-str="%I:%M %p" \
        --date-str="%a, %b %d" \
        --radius=120 \
        --ring-width=8
    '')

    (pkgs.writeShellScriptBin "power-menu" ''
      # Define the menu options
      OPTIONS="1. ☕ Toggle Caffeine (Disable Auto-Sleep)\n2. 🔋 Force 100% Charge\n3. ♻️ Reset TLP Defaults"
  
      # Pipe options into Rofi
      CHOICE=$(echo -e "$OPTIONS" | ${pkgs.rofi}/bin/rofi -dmenu -i -p "Power:")

      # Execute commands based on the selection
      case "$CHOICE" in
        *"Caffeine"*)
          # Assuming you use xset for screen blanking. Adjust if using xautolock or swayidle.
          if xset q | grep -q "DPMS is Enabled"; then
              xset -dpms s off
              ${pkgs.libnotify}/bin/notify-send "Power" "Caffeine ON (Sleep Disabled)"
          else
              xset +dpms s on
              ${pkgs.libnotify}/bin/notify-send "Power" "Caffeine OFF (Normal Sleep)"
          fi
          ;;
      *"100% Charge"*)
          sudo tlp fullcharge BAT0
          ${pkgs.libnotify}/bin/notify-send "TLP" "Charging to 100% temporarily"
          ;;
      *"Reset TLP Defaults"*)
          sudo tlp start
          ${pkgs.libnotify}/bin/notify-send "TLP" "Default power profiles restored"
          ;;
      esac
    '')

    (pkgs.writeShellScriptBin "weather-cache" ''
      CACHE_FILE="$HOME/.cache/weather-cache.txt"
      # Create cache dir if it doesn't exist
      mkdir -p "$HOME/.cache"

      # Try to fetch weather with a 3-second timeout
      if ${pkgs.curl}/bin/curl -s --connect-timeout 3 'https://wttr.in/Salt+Lake+City?format=1' > /tmp/weather.tmp; then
        # If successful, update the cache and print
        cat /tmp/weather.tmp > "$CACHE_FILE"
        cat "$CACHE_FILE"
      else
        # If network is down, read from cache and append an offline indicator
        if [ -f "$CACHE_FILE" ]; then
          echo "[$(cat "$CACHE_FILE")]"
        else
          echo "No Network"
        fi
      fi
    '')
  ];

  home.activation = {
    # 1. Create the persistent directories
    createWorkspaceDirs = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD mkdir -p $HOME/dev
      $DRY_RUN_CMD mkdir -p $HOME/downloads
      $DRY_RUN_CMD mkdir -p $HOME/life
      $DRY_RUN_CMD mkdir -p $HOME/media/pics
      $DRY_RUN_CMD mkdir -p $HOME/media/videos
      $DRY_RUN_CMD mkdir -p $HOME/school
    '';
  };

  home.stateVersion = "25.11"; # DO NOT CHANGE
}


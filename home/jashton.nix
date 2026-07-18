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
    gemini-cli
    intelli-shell
    jrnl
    keepass
    mc
    scrot
    spotify

    (pkgs.writeShellScriptBin "find-open-port" ''
      if [ -z "$1" ]; then
        echo "Please provide an application name, project directory, or other identifier."
        echo "  Usage: find-open-port $HOME/dev/some-project"
        echo "  Usage: find-open-port some-app"
        
        exit 1
      fi

      APP_NAME=$1
      REGISTRY_FILE=$HOME/.dotfiles/ports.registry

      MIN_PORT=8000
      MAX_PORT=8999
      MAX_RETRIES=50

      echo "Searching for available port between $MIN_PORT and $MAX_PORT for $APP_NAME..."

      for ((i=1; i<=MAX_RETRIES; i++)); do
        RANDOM_PORT=$(shuf -i $MIN_PORT-$MAX_PORT -n 1)

        if ! ss -tuln | grep -E -q ":$RANDOM_PORT\b"; then
          if [ -f "$REGISTRY_FILE" ] && grep -q "\b$RANDOM_PORT\b" "$REGISTRY_FILE"; then
            continue
          fi

          echo "$APP_NAME : $RANDOM_PORT" >> "$REGISTRY_FILE"
          echo -e "\nSuccessfully wrote '$APP_NAME : $RANDOM_PORT' to $REGISTRY_FILE"
          exit 0
        fi
      done

      echo -e "\nError: Could not find an open port between $MIN_PORT and $MAX_PORT after $MAX_RETRIES attempts."
      exit 1
    '')

    (pkgs.writeShellScriptBin "wipe" ''
      exit # Not ready for production use.

      LOG_FILE=/dev/null
    
      if [[ "$1" == "-l" || "$1" == "--log-file" && -f "$2" ]]; then
        echo "Log file successfully set to $2"
        LOG_FILE="$2"
      fi

      if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        echo "wipe"
        echo "Created by Josh Ashton"
        echo "me@joshashton.dev\n"
        echo "Run as root or sudo. Use with caution: this command will"
        echo -e "irrevocably erase data.\n"
        echo "Usage:"
        echo -e "  wipe\n  Equivalent to running `wipe --dry-run`"

        echo -e "  wipe { -h | --help }\n  Print this help statement."

        echo -e "  wipe { -f | --log-file } /path/to/filename.log /dev/target\n  Set the log"
        echo "    location explicitly for the next or current use."

        echo -e "  wipe --force /dev/target\nWipe the target drive without confirmation."
        echo "    Cannot be used with --all."

        echo -e "  wipe --all\nAfter verifying system install disk to exclude, wipe all"
        echo "    other attached drives with appropriate methods by bus/media type."
        echo "    Cannot be used with --force."

        echo -e "  wipe --dry-run /dev/target\nRefresh drive map and check if target is detected,"
        echo "    frozen, or locked. Unfreeze if needed. Determine wipe type (ie. "
        echo "    nvme format /dev/target --ses=[0|1|2]; hdparm --security-erase /dev/target;"
        echo "    dd if=/dev/zero of=/dev/target bs=4M status=progress;) and write S.M.A.R.T."
        echo "    test to serial_number.log."

        echo -e "  wipe --self\nSelf-destruct system disk. The same as wipe --self"
        echo "    --force. Use with extreme caution, for emergency use."

        echo -e "\n\nConfiguration Options:"
        echo "  wipe { -l | --log-dir } /path/to/log/location\n  Set a default"
        echo "  location to save log files. The filenames will be"
        echo "  serial_number.log by default."
      fi

      if -z "$1"; then
        echo "TODO: Dry run."
      fi

      if lsblk | grep -q "$1"; then
        read -p "Target $1 found. Confirm Basic Secure Erase. (Y/n): " -r -n 1
        
        if [[ "$REPLY" == "n" ]]; then
          echo "Cancelling Basic Secure Erase."
          exit
        fi

        sudo nvme format "$1" --ses=1 --force | tee $LOG_FILE
        sudo smartctl -a "$1" | tee -a $LOG_FILE
      else
        echo 1 > /sys/bus/pci/rescan
        
      fi
    '')

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

  home.stateVersion = "26.05"; # DO NOT CHANGE
}


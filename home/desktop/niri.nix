{ config, lib, pkgs, inputs, ... }:

let
  launch-lisgd = pkgs.writeShellScriptBin "launch-lisgd" ''
    # Search for the capacitive touch layer and extract its event number.
    # UPDATE 'Touchscreen' below to match the unique word you found in step 1.
    TOUCH_EVENT=$(grep -i -E 'name=".*Finger.*"' -A 5 /proc/bus/input/devices | grep -o 'event[0-9]\+' | head -n 1)
    
    if [ -n "$TOUCH_EVENT" ]; then
      # Start lisgd locked exclusively to the finger digitizer
      ${pkgs.lisgd}/bin/lisgd -t 30 -m 150 -r 45 -d "/dev/input/$TOUCH_EVENT" \
        -g "3,LR,*,*,P,niri msg action focus-column-left && sleep 0.4" \
        -g "3,RL,*,*,P,niri msg action focus-column-right && sleep 0.4" \
        -g "3,UD,*,*,P,niri msg action focus-workspace-up && sleep 0.4" \
        -g "3,DU,*,*,P,niri msg action focus-workspace-down && sleep 0.4" \
        -g "4,DU,*,*,P,dms ipc spotlight toggle && sleep 0.4" \
        -g "1,DU,B,*,pkill -u jashton -RTMIN wvkbd-mobintl && sleep 0.4"
    fi
  '';

  launch-wvkbd = pkgs.writeShellScriptBin "launch-wvkbd" ''
    THEME_CACHE="$HOME/.cache/DankMaterialShell/dms-colors.json"

    if [ -f "$THEME_CACHE" ]; then
      BG=$(jq -r '.["colors"]["dark"]["background"]' "$THEME_CACHE" | tr -d '#')
      FG=$(jq -r '.["colors"]["dark"]["surface_container_lowest"]' "$THEME_CACHE" | tr -d '#')
      TXT=$(jq -r '.["colors"]["dark"]["on_background"]' "$THEME_CACHE" | tr -d '#')
      PRIMARY=$(jq -r '.["colors"]["dark"]["surface_container_lowest"]' "$THEME_CACHE" | tr -d '#')
      ON_PRIMARY=$(jq -r '.["colors"]["dark"]["on_background"]' "$THEME_CACHE" | tr -d '#')
      
      wvkbd-mobintl --hidden --no-popup --bg "$BG" --press "$BG" --fg "$FG" --text "$TXT" --fg-sp "$PRIMARY" --text-sp "$ON_PRIMARY" -L 300
    else
      wvkbd-mobintl --hidden --no-popup
    fi
  '';
in

{

  xdg.portal = {
    enable = true;
    # Use gtk or kde based on your preferred file picker dialog
    config.niri = {
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ]; # or "kde"
    };
    
    # Ensure the GTK portal is installed
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.niri = {
    settings = {
      # Autostart DMS if you prefer launching it directly from Niri instead of systemd
      spawn-at-startup = [
        { command = [ "dms" "run" ]; }
        { command = [ "${launch-wvkbd}/bin/launch-wvkbd" ]; }
        { command = [ "${launch-lisgd}/bin/launch-lisgd" ]; } # Spawns the daemon
      ];

      hotkey-overlay = {
        skip-at-startup = true;
      };

      input = {
        keyboard.xkb.layout = "us";
        touchpad = {
          tap = true;
          natural-scroll = true;
        };
      };

      layout = {
        gaps = 8;
        center-focused-column = "never";
        default-column-width.proportion = 0.985;
        border.enable = false;
        #tab-indicator.corner-radius = 18.0;
        focus-ring = {

          enable = false;
          width = 2;
        };
      };

      prefer-no-csd = true;
      window-rules = [
        { # All windows
          geometry-corner-radius = {
            bottom-left = 25.0;
            bottom-right = 25.0;
            top-right = 25.0;
            top-left = 25.0;
          };

          draw-border-with-background = true;
          clip-to-geometry = true;
        }
        {
          matches = [
            {
              app-id = "google-chrome";
              title = "^Picture-in-Picture$";
            }
          ];
          open-floating = true;
          default-column-width = { fixed = 480; };
          default-window-height = { fixed = 270; };
          default-floating-position = {
            x = 32;
            y = 32;
            relative-to = "bottom-left";
          };
        }
      ];

      # Vim Keybindings & Built-in Features
      binds = with config.lib.niri.actions; {
        # Launchers & Session Control
        "Mod+Return".action.spawn = [ "alacritty" ];
        "Mod+P".action.spawn = [ "pkill" "-RTMIN" "wvkbd-mobintl" ];
        "Mod+Space".action.spawn = [ "dms" "ipc" "spotlight" "toggle" ];
        "Mod+X".action.close-window = [];
        "Mod+F".action.fullscreen-window = [];
        "Mod+Shift+E".action.quit = [];
        "Mod+Shift+P".action.toggle-overview = [];

        # Vim Focus Movement
        "Mod+H".action.focus-column-left = [];
        "Mod+J".action.focus-window-down = [];
        "Mod+K".action.focus-window-up = [];
        "Mod+L".action.focus-column-right = [];

        # Workspace Navigation
        "Mod+N".action.focus-workspace-down = [];
        "Mod+U".action.focus-workspace-up = [];

        # Vim Window Reordering
        "Mod+Shift+H".action.move-column-left = [];
        "Mod+Shift+L".action.move-column-right = [];
        "Mod+Shift+J".action.move-column-to-workspace-down = [];
        "Mod+Shift+K".action.move-column-to-workspace-up = [];

        # Volume & Brightness Media Controls
        "XF86AudioRaiseVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+" ];
        "XF86AudioLowerVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-" ];
        "XF86AudioMute".action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
        "XF86MonBrightnessUp".action.spawn = [ "dms" "ipc" "call" "brightness" "increment" "5" "" ];
        "XF86MonBrightnessDown".action.spawn = [ "dms" "ipc" "call" "brightness" "decrement" "5" "" ];
        
        # Screenshots
        "Print".action.screenshot = [];
        "Ctrl+Print".action.screenshot-screen = [];
      };
    };
  };
}



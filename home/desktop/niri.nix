{ config, lib, pkgs, inputs, ... }:

{
  imports = [ 
    inputs.dms.homeModules.dank-material-shell
  ];


  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
  };

  #systemd.user.services.niri-flake-polkit.enable = false;

  # 2. Enable & Configure Niri
  programs.niri = {
    # Declarative KDL configuration for Niri
    settings = {
      # Autostart DMS if you prefer launching it directly from Niri instead of systemd
      # spawn-at-startup = [ { command = [ "dms" ]; } ];

      # Core keybindings
      binds = {
        "Mod+Return".action.spawn = "alacritty"; # Or your preferred terminal
        "Mod+X".action.close-window = [];
        "Mod+Shift+E".action.quit = [];

        # Focus / Column movement
        "Mod+H".action.focus-column-left = [];
        "Mod+L".action.focus-column-right = [];
        "Mod+J".action.focus-window-or-workspace-down = [];
        "Mod+K".action.focus-window-or-workspace-up = [];

        # DMS Launcher integration (if you want a hotkey bound directly)
        "Mod+Space".action.spawn = [ "dms" "ipc" "call" "launcher" "toggle" ];
      };

      # Window & Layer Rules (e.g. enable background blur for DMS components)
#      layer-rules = [
#        {
#          geometry-corner-radius = 12;
#          background-effect = {
#            blur = true;
#          };
#        }
#      ];
    };
  };
}

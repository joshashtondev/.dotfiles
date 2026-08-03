{ config, lib, pkgs, inputs, ... }:

let
  # Compile your custom wvkbd build
  custom_wvkbd = pkgs.wvkbd.overrideAttrs (oldAttrs: {
    # Pin the package version to the exact commit from your flake input
    src = inputs.wvkbd-src;
    version = "custom-git";

    # Choose your preferred layout layout (e.g., mobintl, standard, cyrillic)
    makeFlags = (oldAttrs.makeFlags or []) ++ [ "LAYOUT=mobintl" ];

    # Optional: Swap out the layout with your own config.h file if you have one
    preBuild = ''
      cp ${./programs/layout.custom.h} layout.mobintl.h
      cp ${./programs/config.custom.h} config.mobintl.h
      cp ${./programs/keymap.custom.h} keymap.mobintl.h
    '';
  });
in
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
    NIXOS_OZONE_WL = "1";                    # Forces Electron/Chromium apps to use Wayland natively
    GTK_IM_MODULE = "wayland";               # Forces GTK apps to use Wayland text-input protocols
    QT_IM_MODULE = "wayland";                # Forces Qt apps to use Wayland text-input protocols
    TEXT_INPUT_PRESENT = "1";                # Explicitly signals virtual keyboard capability to the shell
  };
  
  home.packages = with pkgs; [
    aider-chat
    animdl
    antigravity
    asciinema
    discord
    ffmpeg
    freetube
    gemini-cli
    intelli-shell
    jrnl
    libreoffice
    mc
    opencode
    pdftk
    scrot
    steam
    spotify
    vlc
    wtype
    xwayland-satellite
    yt-dlp
    zathura

    custom_wvkbd

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


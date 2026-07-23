{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    acpi
    alacritty
    btop
    dconf
    dunst
    fastfetch
    firefox
    git
    github-cli
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-panel
    gnomeExtensions.gjs-osk
    gnomeExtensions.gsconnect
    gnomeExtensions.just-perfection
    gnomeExtensions.removable-drive-menu
    gnome-keyring
    gnome-network-displays
    google-chrome
    libnotify
    mypy
    networkmanagerapplet
    nitrogen
    pasystray
    picom
    polkit_gnome
    pulseaudioFull
    rnote
    tldr
    tmux
    unrar
    unzip
    v4l-utils
    vim
    wget
    xclip
    xournalpp

    (pkgs.writeShellScriptBin "unix" ''
      set -u

      DOTFILES="$HOME/.dotfiles"
      ERRFILE=$(mktemp)
      trap "rm -f '$ERRFILE'" EXIT

      echo "Building NixOS..."
      sudo nixos-rebuild switch --flake "$DOTFILES#thinkpad" 2>&1 | tee "$ERRFILE"
      STATUS=''${PIPESTATUS[0]}

      if [ "$STATUS" -ne 0 ]; then
        PATTERN=$(find "$DOTFILES" -type f -name "*.nix" -printf "%f\n" | sort -u | tr '\n' '|' | sed 's/|$//')
        MATCHES=$(grep -E "$PATTERN" "$ERRFILE" | sort -u)
        if [ -n "$MATCHES" ]; then
          printf '\nErrors in repo files:\n%s\n' "$MATCHES"
        fi
        exit 1
      fi

      GEN=$(readlink /nix/var/nix/profiles/system | sed 's/system-\([0-9]*\)-link/\1/')
      VER=$(nixos-version)
      TIMESTAMP=$(date '+%Y-%m-%d %H:%M')

      cd "$DOTFILES"

      if [ -z "$(${pkgs.git}/bin/git status --porcelain)" ]; then
        echo "Generation $GEN active — no config changes to commit."
        exit 0
      fi

      ${pkgs.git}/bin/git add -A
      ${pkgs.git}/bin/git commit -m "nixos: gen $GEN @ $(hostname) — $TIMESTAMP

$VER"
      ${pkgs.git}/bin/git push
    '')
  ];

  programs.firefox.enable = true;
  programs.thunar.enable = true;
}

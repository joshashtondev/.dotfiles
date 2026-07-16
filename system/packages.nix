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
    gnome-keyring
    google-chrome
    libnotify
    mypy
    networkmanagerapplet
    nitrogen
    pasystray
    picom
    polkit_gnome
    pulseaudioFull
    tldr
    tmux
    unrar
    unzip
    vim
    wget
    xclip
  ];

  programs.firefox.enable = true;
  programs.thunar.enable = true;
}

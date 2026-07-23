{ config, pkgs, ... }:

{
  imports = [
    ./dunst.nix
    ./gnome.nix
    ./i3.nix
    ./polybar.nix
    ./rofi.nix
  ];
}

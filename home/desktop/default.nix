{ config, pkgs, inputs, ... }:

{
  imports = [
    #./kde.nix
    ./niri.nix
    #./dunst.nix
    #./gnome.nix
    #./i3.nix
    #./polybar.nix
    #./rofi.nix
  ];
}

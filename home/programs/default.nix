{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./git.nix
    ./nvim.nix
  ];
}

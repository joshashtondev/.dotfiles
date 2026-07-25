{ config, dms, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./git.nix
    ./nvim.nix
  ];
}

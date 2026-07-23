{ config, pkgs, ... }:

{
  imports = [
    ./audio.nix
    ./boot.nix
    ./env.nix
    ./locale.nix
    ./power.nix
  ];
}

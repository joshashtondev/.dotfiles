{ config, pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./env.nix
    ./locale.nix
    ./power.nix
  ];
}

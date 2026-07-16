{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./core
    ./network
    ./security
    ./services
    ./virtualisation
  ];
}

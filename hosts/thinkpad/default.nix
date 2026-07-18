{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../system
    ../../system/security/thinkpad.nix
  ];

  networking.hostName = "nix-pad";

  system.stateVersion = "26.05";
}

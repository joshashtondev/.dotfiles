{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../system
    ../../system/security/thinkpad.nix
  ];

  networking.hostName = "nix-pad";

  services.power-profiles-daemon.enable = false;

  system.stateVersion = "26.05";
}

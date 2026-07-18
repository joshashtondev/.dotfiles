{ config, pkgs, ... }:

{

  imports = [
    ./pi-hole.nix
  ];

  networking = {
    networkmanager.enable = true;
    
    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
  };
}

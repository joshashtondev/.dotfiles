{ config, pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;
    
    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
  };
}

{ config, pkgs, ... }:

{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };

    virtualbox.host.enable = true;
    libvirtd.enable = true;
  };
}

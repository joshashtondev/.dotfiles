{ config, pkgs, ... }:

{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };

    waydroid.enable = true;

    virtualbox.host.enable = true;
    libvirtd.enable = true;
  };
}

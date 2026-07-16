{ config, pkgs, ... }:

{
  imports = [
    ./sudo.nix
    ./systemd.nix
    ./users.nix
  ];

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };
}

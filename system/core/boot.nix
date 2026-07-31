{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages;
  boot.kernelModules = [ "uinput" ];
  system.nixos.label = "niri-v.1.1";
  environment.pathsToLink = [ "/libexec" ];
}

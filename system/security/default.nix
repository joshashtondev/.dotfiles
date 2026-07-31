{ config, pkgs, ... }:

{
  imports = [
    ./sudo.nix
    ./systemd.nix
    ./users.nix
  ];

  security = {
    pam.services.swaylock = {};
    polkit.enable = true;
    rtkit.enable = true;

    tpm2 = {
      enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };
  };


  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
  '';
}

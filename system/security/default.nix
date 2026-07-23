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

    tpm2 = {
      enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };
  };
}

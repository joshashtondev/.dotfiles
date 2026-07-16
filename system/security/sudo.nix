{ config, pkgs, ... }:

{
  security.sudo.extraRules = [
    {
      users = [ "jashton" ];

      commands = [
        {
          command = "/run/current-system/sw/bin/tlp";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}

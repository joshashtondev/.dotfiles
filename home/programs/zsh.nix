{ config, pkgs, ... }:

{
  programs.zsh = {
    initExtra = ''
      if [ -f "/run/secrets/vaultwarden_clientid" ]; then
        export BW_CLIENTID=$(cat /run/secrets/vaultwarden_clientid)
      fi

      if [ -f "/run/secrets/vaultwarden_clientsecret" ]; then
        export BW_CLIENTSECRET=$(cat /run/secrets/vaultwarden_clientsecret)
      fi
    '';
  };
}

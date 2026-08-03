{ config, pkgs, ... }:

{
  sops.defaultSopsFile = ../../secrets/secrets.yaml;

  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  sops.secrets."vaultwarden_clientid".owner = config.users.users.jashton.name;
  sops.secrets."vaultwarden_clientsecret".owner = config.users.users.jashton.name;
}

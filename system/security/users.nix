{ config, pkgs, ... }:

{
  users.groups.jashton = {};
  users.users.jashton = {
    isNormalUser = true;
    description = "Josh Ashton";
    group = "jashton";
    extraGroups = [ "networkmanager" "wheel" "tss" "video" "audio" "input" ];

    shell = pkgs.zsh;
  };

  users.users.root = {
    shell = pkgs.zsh;
  };
}

{ config, pkgs, ... }:

{
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true; 
    syntaxHighlighting.enable = true;

    histSize = 1000000;
    
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
    ];

    shellAliases = {
      enix = "nvim $HOME/.dotfiles/flake.nix";
      unix = "sudo nixos-rebuild switch --flake $HOME/.dotfiles#thinkpad";
      ehome = "nvim $HOME/.dotfiles/home/jashton.nix";
      l = "ls -la";
      ports = "cat $HOME/.dotfiles/ports.registry";
    };

    ohMyZsh = {
      enable = true;
      theme = "aussiegeek";
      plugins = [
        "git"
      ];
    };
  };
}

{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "joshashtondev";
        email = "me@joshashton.dev";
      };

      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };

    ignores = [
      ".env"
      "*.log"
      "*.swp"
      ".DS_STORE"
    ];
  };
}

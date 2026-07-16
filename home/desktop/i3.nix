{ config, pkgs, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;
    config = null;
    extraConfig = (builtins.readFile ./i3/config) + ''
      exec --no-startup-id ${pkgs.feh}/bin/feh --bg-fill ${./assets/samuraii.jpg}
    '';
  };
}

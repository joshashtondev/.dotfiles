{ config, pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    config.common = {
      # Direct camera and permission requests strictly to GNOME
      "org.freedesktop.impl.portal.Camera" = "gnome";
      "org.freedesktop.impl.portal.Access" = "gnome";
      
      # Keeps your existing layout working
      "org.freedesktop.impl.portal.Screenshot" = "gnome";
      "org.freedesktop.impl.portal.ScreenCast" = "gnome";
    };
  };

  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    gnome = {
      core-apps.enable = true;
      core-developer-tools.enable = true;
      games.enable = true;
    };

    xserver = {
      enable = true;

      xkb = {
        variant = "";
        layout = "us";
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          brightnessctl
          dmenu
          i3lock-color
          playerctl
          rofi
          xautolock
        ];
      };
    };

    libinput = {
      enable = true;
    };

    openssh = {
      enable = false;
    };

    printing.enable = true;
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    blueman.enable = true;
  };
}

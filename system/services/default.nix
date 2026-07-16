{ config, pkgs, ... }:

{
  services = {
    displayManager = {
      ly.enable = true;
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

    picom = {
      enable = true;
      backend = "glx";
      vSync = true;
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
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };
}

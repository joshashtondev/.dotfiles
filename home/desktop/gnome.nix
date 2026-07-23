{ config, lib, pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      accent-color = "purple";
    };

    "org/gnome/shell" = {
      enabled-extensions = [
        pkgs.gnomeExtensions.blur-my-shell.extensionUuid
        pkgs.gnomeExtensions.caffeine.extensionUuid
        pkgs.gnomeExtensions.clipboard-indicator.extensionUuid
        pkgs.gnomeExtensions.dash-to-panel.extensionUuid
        pkgs.gnomeExtensions.gjs-osk.extensionUuid
        pkgs.gnomeExtensions.gsconnect.extensionUuid
        pkgs.gnomeExtensions.just-perfection.extensionUuid
        pkgs.gnomeExtensions.removable-drive-menu.extensionUuid
      ];
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gnome";
    style.name = "adwaita-dark";
  };
}

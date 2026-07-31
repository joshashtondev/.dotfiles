{ config, pkgs, inputs, ... }:

let
  # Instantiate the unstable package set for your system architecture
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true; 
  };
in
{
  imports = [
    inputs.dms.nixosModules.greeter
  ];

  programs.niri = {
    enable = true;
    # Tell the Niri module to use the unstable package directly from the niri-flake
    package = inputs.niri.packages.${pkgs.system}.niri-unstable;
  };

  programs.dsearch.enable = true;

  programs.dank-material-shell.greeter = {
    enable = true;
    compositor.name = "niri";

    configHome = "/home/jashton";
  };

  programs.dms-shell = {
    enable = true;
    enableSystemMonitoring = true;
    enableVPN = true;            
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;

    systemd = {
      enable = false;
      restartIfChanged = true;
    };

    quickshell.package = unstable.quickshell;

    plugins = {
      developerUtilities.enable = true;
      batteryPlus.enable = true;
      mediaDownloader.enable = true;
      dankBatteryAlerts.enable = true;
      dmsThemeSync.enable = true;
      dmsPass.enable = true;
    };
  };

  services = {
    libinput = {
      enable = true;
    };

    openssh = {
      enable = false;
    };

    upower.enable = true;
    printing.enable = true;
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    blueman.enable = true;
  };
}

{ config, pkgs, ... }:

{
  boot.kernelParams = [ "mem_sleep_default=deep" ];

  services.power-profiles-daemon.enable = false;

  services.tlp = {
    enable = true;
    settings = {
      USB_AUTOSUSPEND = 0;

      # AC
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      SOUND_POWER_SAVE_ON_AC = 0;
      PCIE_ASPM_ON_AC = "default";
      CPU_BOOST_ON_BAT = 0;

      # Battery
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      SOUND_POWER_SAVE_ON_BAT = 1;
      PCIE_ASPM_ON_BAT = "powersupersave";
      CPU_BOOST_ON_AC = 1;

      # Battery Thresholds
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };
}

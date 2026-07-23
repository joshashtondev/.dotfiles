{ config, lib, pkgs, ... }:

{
  security.rtkit.enable = true;
  services.avahi.enable = true;
  services.pulseaudio.enable = false;

  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
  };

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    wireplumber.enable = true;
    raopOpenFirewall = true;

    # Dynamic, optimized buffer sizes to eliminate data starvation
    extraConfig.pipewire = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 1024;
        "default.clock.min-quantum" = 512;
        "default.clock.max-quantum" = 2048;
      };

      "10-airplay" = {
        "context-modules" = [
          {
            name = "libpipewire-module-raop-discover";
          }
        ];
      };
    };

    wireplumber.extraConfig = {
      "10-bluetooth-policy" = {
        "wireplumber.settings" = {
          "bluetooth.autoswitch-to-headset" = false;
        };
      };

      # Properly disables node suspension using WirePlumber 0.5+ syntax
      "10-disable-suspend" = {
        "monitor.bluez.rules" = [
          {
            matches = [
              {
                "node.name" = "~bluez_output.*";
              }
            ];
            actions = {
              update-props = {
                "session.suspend-timeout-seconds" = 0;
              };
            };
          }
        ];
      };

      # Force High Quality Audio profiles ONLY (Blocks Handsfree Mic Downgrades)
      "11-bluetooth-enhancements" = {
        "monitor.bluez.properties" = {
          "bluez5.roles" = [ "a2dp_sink" "a2dp_source" ];
          "bluez5.codecs" = [ "aac" "aptx" "sbc" ];
          "bluez5.enable-sbc-xq" = false;
          "bluez5.enable-hw-volume" = true;
        };
      };
    };
  };
}

{ config, pkgs, ... }:

{
  services.polybar = {
    enable = true;
    script = "polybar main &";

    package = pkgs.polybar.override {
      i3Support = true;
      pulseSupport = true;
    };

    config = {
      "colors" = {
        background = "#08090b";
        foreground = "#8d739c";
        bg-alt1 = "#1e1f21";
        bg-alt2 = "#2c2137";
        accent = "#4f3963";
        text-light = "#847397";
      };

      "bar/main" = {
        width = "100%";
        height = "24pt";
        background = "\${colors.background}";
        foreground = "\${colors.foreground}";
        
        # This gives you the gap between the screen edge and your blocks
        padding-left = 0;
        padding-right = 0;
        
        # The physical empty space between each pill
        module-margin = 1;

        # True Center Alignment!
        modules-left = "i3 weather";
        modules-center = "date";
        modules-right = "spotify pulseaudio wlan battery";

        font-0 = "Hack Nerd Font Mono:size=12;3";
        font-1 = "Noto Color Emoji:scale=12;3";
        font-2 = "Hack Nerd Font Mono:size=16;3";
      };

      # --- NATIVE INTERNAL MODULES --- #

      "module/i3" = {
        type = "internal/i3";
        format = "<label-state>";
        strip-wsnumbers = true;
        
        # Adding padding creates the "pill" width
        label-focused = "%name%";
        label-focused-background = "\${colors.bg-alt2}";
        label-focused-foreground = "\${colors.text-light}";
        label-focused-padding = 1;
        
        label-unfocused = "%name%";
        label-unfocused-background = "\${colors.background}";
        label-unfocused-padding = 1;
      };

      "module/date" = {
        type = "internal/date";
        interval = 1;
        date = "%a, %b %d";
        time = "%I:%M %p";
        label = " %date%   %time% ";
        label-background = "\${colors.accent}";
        label-foreground = "#08090b";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        format-volume = "<label-volume>";
        label-volume = "  %percentage%% ";
        label-volume-background = "\${colors.bg-alt2}";
        label-volume-foreground = "\${colors.text-light}";
        
        label-muted = "  Muted ";
        label-muted-background = "\${colors.bg-alt2}";
        label-muted-foreground = "#4f3963";
      };

      "module/wlan" = {
        type = "internal/network";
        # Polybar automatically detects your wireless interface
        interface-type = "wireless"; 
        interval = 3;

        # Action Tag: Left-click launches Alacritty with NetworkManager TUI
        format-connected = "<label-connected>";
        label-connected = "%{A1:alacritty -e nmtui:} %{T3}%{T-} %essid% %{A}";
        label-connected-background = "\${colors.bg-alt1}";
        label-connected-padding = 1;

        format-disconnected = "<label-disconnected>";
        label-disconnected = "%{A1:alacritty -e nmtui:} %{T3}󰖪%{T-} Offline %{A}";
        label-disconnected-background = "\${colors.bg-alt1}";
        label-disconnected-foreground = "#900000"; # Red alert when down
        label-disconnected-padding = 1;
      };

      "module/battery" = {
        type = "internal/battery";
        full-at = 99;
        low-at = 10;
        battery = "BAT0"; 
        adapter = "AC";
        
        format-charging = "<label-charging>";
        label-charging = "%{A1:power-menu:} ⚡ %percentage%% %{A1}";
        label-charging-background = "\${colors.bg-alt1}";

        format-notcharging = "<label-notcharging>";
        label-notcharging = "%{A1:power-menu:} ⏸️  %percentage%% %{A}";
        label-notcharging-background = "\${colors.bg-alt1}";
        
        format-discharging = "<label-discharging>";
        label-discharging = "%{A1:power-menu:}  %percentage%% %{A1}";
        label-discharging-background = "\${colors.bg-alt1}";
      };

      # --- CUSTOM SCRIPT MODULES --- #

      "module/weather" = {
        type = "custom/script";
        # Call the script we just built in home.packages
        exec = "weather-cache";
        interval = 3600;
        label = " %output% ";
        format-background = "\${colors.bg-alt1}";
      };

    };
  };
}

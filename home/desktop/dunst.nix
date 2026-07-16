{ config, lib, pkgs, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "14x50";
        origin = "top-right";
        transparency = 10;
        font = "Hack Nerd Font Mono 12";
        
        # Geometry and base borders
        frame_width = 2;
        separator_color = "#2c2137"; # Midnight Violet
      };

      urgency_low = {
        background = "#1e1f21"; # Carbon Black
        foreground = "#7e6790"; # Vintage Lavender 2 (Subtle text for low priority)
        frame_color = "#2c2137"; # Midnight Violet (Darkest accent)
        timeout = 5;
      };

      urgency_normal = {
        background = "#1e1f21"; # Carbon Black
        foreground = "#8d739c"; # Vintage Lavender 1 (Primary readable text)
        frame_color = "#4f3963"; # Vintage Grape (Your primary accent)
        timeout = 10;
      };
      
      urgency_critical = {
        # Flipping the background to Midnight Violet to make it pop slightly
        background = "#2c2137"; 
        foreground = "#8d739c"; # Vintage Lavender 1
        frame_color = "#847397"; # Vintage Lavender 3 (Brightest accent for critical)
        timeout = 0; # Stays on screen until explicitly dismissed
      };
    };
  };
}

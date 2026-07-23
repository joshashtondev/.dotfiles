{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    theme = "hyper";

    settings = {
      window = {
        padding = { x = 10; y = 10; };
        opacity = .9;
      };

      font = {
        normal = {
          family = "Hack Nerd Font";
          style = "Mono";
        };
        size = 14.0;
      };

      colors = {
        primary = {
          background = "#08090b"; # Black
          foreground = "#8d739c"; # Vintage Lavender 1
        };
        
        normal = {
          black   = "#1e1f21"; # Carbon Black
          red     = "#4f3963"; # Vintage Grape
          green   = "#7e6790"; # Vintage Lavender 2
          yellow  = "#847397"; # Vintage Lavender 3
          blue    = "#2c2137"; # Midnight Violet
          magenta = "#8d739c"; # Vintage Lavender 1
          cyan    = "#7e6790"; # Vintage Lavender 2
          white   = "#323335"; # Graphite
        };

        # Bright colors map to the same palette for a consistent, flat aesthetic
        bright = {
          black   = "#323335"; # Graphite
          red     = "#4f3963"; # Vintage Grape
          green   = "#7e6790"; # Vintage Lavender 2
          yellow  = "#847397"; # Vintage Lavender 3
          blue    = "#2c2137"; # Midnight Violet
          magenta = "#8d739c"; # Vintage Lavender 1
          cyan    = "#7e6790"; # Vintage Lavender 2
          white   = "#8d739c"; # Vintage Lavender 1
        };
      };

      scrolling.multiplier = 3;
    };
  };
}

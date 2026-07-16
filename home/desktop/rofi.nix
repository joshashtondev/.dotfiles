{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    
    # Optional: ensure it uses your configured terminal
    terminal = "${pkgs.alacritty}/bin/alacritty";
    font = "Hack Nerd Font Mono 12";

    theme = let
      # Pulls in the mkLiteral function specifically for Rofi
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        # Your Vintage Lavender Palette
        bg0 = mkLiteral "#08090b"; # Black
        bg1 = mkLiteral "#1e1f21"; # Carbon Black
        bg2 = mkLiteral "#2c2137"; # Midnight Violet
        fg0 = mkLiteral "#8d739c"; # Vintage Lavender 1
        fg1 = mkLiteral "#847397"; # Vintage Lavender 3
        accent = mkLiteral "#4f3963"; # Vintage Grape
        
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg0";
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        spacing = mkLiteral "0px";
      };

      "window" = {
        background-color = mkLiteral "@bg0";
        border = mkLiteral "2px";
        border-color = mkLiteral "@accent";
        border-radius = mkLiteral "6px";
        width = mkLiteral "600px";
      };

      "inputbar" = {
        padding = mkLiteral "12px";
        background-color = mkLiteral "@bg1";
        border = mkLiteral "0px 0px 2px 0px";
        border-color = mkLiteral "@accent";
      };

      "entry" = {
        padding = mkLiteral "0px 12px";
        vertical-align = mkLiteral "0.5";
      };

      "prompt" = {
        vertical-align = mkLiteral "0.5";
        text-color = mkLiteral "@accent";
      };

      "listview" = {
        padding = mkLiteral "8px";
        lines = 8;
        columns = 1;
        fixed-height = mkLiteral "false";
      };

      "element" = {
        padding = mkLiteral "8px";
        spacing = mkLiteral "8px";
        border-radius = mkLiteral "4px";
      };

      "element-text, element-icon" = {
        vertical-align = mkLiteral "0.5";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "element selected" = {
        background-color = mkLiteral "@bg2";
        text-color = mkLiteral "@fg0";
        border = mkLiteral "1px";
        border-color = mkLiteral "@accent";
      };
    };
  };
}

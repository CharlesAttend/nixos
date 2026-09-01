{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    theme = "Arc"; # Named theme or path to .rasi file
    plugins = [
      pkgs.rofi-calc
    ];
  };

  home.packages = with pkgs; [
    rofimoji
  ];
}

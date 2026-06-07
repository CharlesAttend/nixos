{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  services.displayManager.sddm.enable = true;
  programs.hyprlock.enable = true;
  environment.systemPackages = with pkgs; [
    dunst # Notification Daemon
    rofi # picker
    rofi-calc
    rofimoji
    hyprmon
    hyprpicker
    hyprshot
    hyprcursor
    hyprpolkitagent
    nautilus
    adwaita-icon-theme
    clipse
    wl-clip-persist
    hyprsunset
    wpaperd
    brightnessctl
  ];
  # for nautilus to work
  services.gvfs.enable = true; 
  # Add hyprcursor theme to config 
  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}

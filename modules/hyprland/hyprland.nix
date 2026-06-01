{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  programs.uwsm.enable = true;
  programs.hyprlock.enable = true;
  environment.systemPackages = with pkgs; [
    dunst # Notification Daemon
    rofi # picker
    rofi-calc
    rofi-emoji
    hyprmon
    hyprpicker
    hyprshot
    hyprcursor
    nautilus
    clipse
    wl-clip-persist
    hyprsunset
    wpaperd
  ];

  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}

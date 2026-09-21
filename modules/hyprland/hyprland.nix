{
  config,
  pkgs,
  inputs,
  ...
}:

let
  unstable = import inputs.nixpkgs-unstable { inherit (pkgs.stdenv.hostPlatform) system; };
in
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = unstable.hyprland;
    portalPackage = unstable.xdg-desktop-portal-hyprland;
  };
  services.displayManager.sddm.enable = true;
  programs.hyprlock.enable = true;
  environment.systemPackages = with pkgs; [
    dunst # Notification Daemon
    libnotify
    wl-clipboard
    wtype

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

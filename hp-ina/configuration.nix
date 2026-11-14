{ config, pkgs, ... }:

{
  imports = [
    ../base.nix
    ../daily.nix
    ../modules/hyprland/hyprland.nix
    ./hardware.nix
    ./games.nix
    ./taf.nix
    ./taf_imprimante.nix
    ./vpn_and_2fa.nix
    ./displaylink.nix
    ./battery-notification.nix
  ];
  programs.nix-ld.enable = true;
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchExternalPower = "suspend";
  };
  networking.hostName = "hp-ina";

  system.stateVersion = "25.11"; # don't touch that bro
}

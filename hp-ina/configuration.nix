{ config, pkgs, ... }:

{
  imports = [
    ../base.nix
    ../daily.nix
    ../modules/hyprland/hyprland.nix
    ./hardware.nix
    ./origin_conf.nix
    ./games.nix
    ./vpn_and_2fa.nix
    ./displaylink.nix
  ];
  networking.hostName = "hp-ina";
}

{ config, pkgs, ... }:

{
  imports = [
    ../base.nix
    ../daily.nix
    ./hardware.nix
    ./origin_conf.nix
    ./games.nix
    ./vpn_and_2fa.nix
  ];
  networking.hostName = "hp-ina";
}

{ config, pkgs, ... }:

{
  imports = [
    ../base.nix
    ../daily.nix
    ./hardware.nix
    ./origin_conf.nix
  ];
  networking.hostName = "hp-ina";
}

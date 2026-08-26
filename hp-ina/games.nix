{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    factorio-space-age
  ];
  system.extraDependencies = [
    pkgs.factorio-space-age.src
  ];
}

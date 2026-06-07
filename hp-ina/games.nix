{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # factorio-space-age
  ];
  # system.extraDependencies = [
  #   factorio.src
  # ];
}

{ config, lib, pkgs, ... }:

{
  # Immich
  services.immich = {
    enable = true;
    machine-learning.enable = true;
    port = 2283;
    secretsFile = "/run/secrets/immich";
    environment = {
    };
    openFirewall = true;
    mediaLocation = "/mnt/data/immich/media";
  };
  services.immich.accelerationDevices = null; # all devices
  users.users.immich.extraGroups = [ "video" "render" ];
  user.users.charles.extraGroups = [ "immich" ];
}

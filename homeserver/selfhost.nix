{ config, lib, pkgs, ... }:

{
  # Immich
  services.immich = {
     enable = true;
     machine-learning.enable = true;
     port = 2283;
     secretsFile = "/run/secrets/immich";
     environment = {
       # "DB_DATA_LOCATION" = "/mnt/data/immich";
     };
     openFirewall = true;
  };
  users.users.immich.extraGroups = [ "video" "render" ];
}

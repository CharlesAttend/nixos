{ config, lib, pkgs, ... }:

{
  # Immich
  services.immich = {
     enable = true;
     machine-learning.enable = true;
     port = 2283;
     secretsFile = "/run/secrets/immich";
     environment = {
       # "DB_DATA_LOCATION" = "";
     };
     openFirewall = true;
  };
  users.users.immich.extraGroups = [ "video" "render" ];
}

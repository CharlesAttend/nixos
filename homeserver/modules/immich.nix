{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  services.immich = {
    enable = true;
    package = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.immich;
    machine-learning.enable = true;
    port = 2283;
    openFirewall = true;
    host = "0.0.0.0";
    mediaLocation = "/mnt/data/immich/media";
    accelerationDevices = null; # all devices
    environment = {
      TZ = "Europe/Paris";
    };
  };
  users.users.immich.extraGroups = [
    "video"
    "render"
  ];
  users.users.charles.extraGroups = [ "immich" ];

  services.traefik = {
    dynamicConfigOptions.http = {
      routers = {
        immich = {
          entryPoints = [ "websecure" ];
          service = "immich";
          rule = "Host(`immich.home.charles.vin`)";
          tls.certResolver = "letsencrypt";
        };
      };

      services = {
        immich.loadBalancer.servers = [
          { url = "http://localhost:${toString config.services.immich.port}"; }
        ];
      };
    };
  };
}

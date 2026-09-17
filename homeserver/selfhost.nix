{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  services.paperless = {
    enable = true;
  };

  sops.secrets.cloudflare-traefik = {
    sopsFile = ../secrets/cloudflare-traefik.env;
    format = "dotenv";
    # restartunits = [ "traefik.service" ];
  };
  services.traefik = {
    enable = true;
    staticConfigOptions = {
      entryPoints = {
        web = {
          address = ":80";
          asDefault = true;
          http.redirections.entrypoint = {
            to = "websecure";
            scheme = "https";
          };
        };

        websecure = {
          address = ":443";
          asDefault = true;
          http.tls.certResolver = "letsencrypt";
        };
      };
      certificatesResolvers.letsencrypt.acme = {
        email = "charles.vin@outlook.fr";
        dnschallenge.provider = "cloudflare";
      };
      api.dashboard = true;
      api.insecure = true;
      accessLog = {
        filePath = "${config.services.traefik.dataDir}/traefik_access.log";
        format = "json";
      };
      log = {
        level = "DEBUG";
        filePath = "${config.services.traefik.dataDir}/traefik.log";
        format = "json";
      };
    };
    environmentFiles = [ config.sops.secrets.cloudflare-traefik.path ];
  };
  networking.firewall.allowedTCPPorts = [
    8080 # Traefik dashboard
    80
    443
  ];
}

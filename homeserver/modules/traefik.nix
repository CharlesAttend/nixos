{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  sops.secrets.cloudflare-traefik = {
    sopsFile = ../../secrets/cloudflare-traefik.env;
    format = "dotenv";
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
    };
    environmentFiles = [ config.sops.secrets.cloudflare-traefik.path ];
  };
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}

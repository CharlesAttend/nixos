{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Immich
  services.immich = {
    enable = true;
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

  # Homeassistant
  virtualisation.oci-containers = {
    backend = "docker";
    containers.homeassistant = {
      volumes = [
        "home-assistant:/config"
        "/run/udev:/run/udev:ro"
        "/dev:/dev"
      ];
      environment.TZ = "Europe/Berlin";
      # Note: The image will not be updated on rebuilds, unless the version label changes
      image = "ghcr.io/home-assistant/home-assistant:stable";
      extraOptions = [
        # Use the host network namespace for all socket
        "--network=host"
        "--device-cgroup-rule=c 188:* rmw"
      ];
    };
  };

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
      log = {
        level = "DEBUG";
        filePath = "${config.services.traefik.dataDir}/traefik.log";
        format = "json";
      };
    };

    dynamicConfigOptions.http = {
      routers = {
        hass = {
          entryPoints = [ "websecure" ];
          service = "hass";
          rule = "Host(`home.charles.vin`) || PathPrefix(`/hass`)";
          tls.certResolver = "letsencrypt";
        };
        paperless = {
          entryPoints = [ "websecure" ];
          service = "paperless";
          rule = "PathPrefix(`/documents`)";
          tls.certResolver = "letsencrypt";
        };
      };

      services = {
        hass.loadBalancer.servers = [ { url = "http://localhost:8123"; } ];
        paperless.loadBalancer.servers = [
          { url = "http://localhost:${toString config.services.paperless.port}"; }
        ];
      };
    };
    environmentFiles = [ config.sops.secrets.cloudflare-traefik.path ];
  };
  networking.firewall.allowedTCPPorts = [
    8123 # Homeassistant

    8080 # Traefik dashboard
    80
    443
  ];
}

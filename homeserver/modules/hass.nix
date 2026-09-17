{
  config,
  lib,
  pkgs,
  ...
}:

{
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
    containers.matterbridge = {
      volumes = [
        "/home/charles/Matterbridge:/root/Matterbridge"
        "/home/charles/.matterbridge:/root/.matterbridge"
        "/home/charles/.mattercert:/root/.mattercert"
      ];
      image = "luligu/matterbridge:latest";
      extraOptions = [
        "--stop-timeout=60"
        "--network=host"
      ];
    };
  };

  services.traefik = {
    dynamicConfigOptions.http = {
      routers = {
        hass = {
          entryPoints = [ "websecure" ];
          service = "hass";
          rule = "Host(`hass.home.charles.vin`)";
          tls.certResolver = "letsencrypt";
        };
      };

      services = {
        hass.loadBalancer.servers = [ { url = "http://localhost:8123"; } ];
      };
    };
  };
  networking.firewall.allowedTCPPorts = [
    8123 # Homeassistant
    8283 # Matterbridge
  ];
}

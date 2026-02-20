{ config, lib, pkgs, ... }:

{
  # Immich
  services.immich = {
    enable = true;
    machine-learning.enable = true;
    port = 2283;
    secretsFile = "/run/secrets/immich";
    openFirewall = true;
    host = "0.0.0.0";
    mediaLocation = "/mnt/data/immich/media";
    accelerationDevices = null; # all devices
  };
  users.users.immich.extraGroups = [ "video" "render" ];
  users.users.charles.extraGroups = [ "immich" ];

  # Homeassistant
  virtualisation.oci-containers = {
    backend = "docker";
    containers.homeassistant = {
      volumes = [ "home-assistant:/config" "/run/udev:/run/udev:ro" "/dev:/dev" ];
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
  networking.firewall.allowedTCPPorts = [
    8123   
  ];
} 

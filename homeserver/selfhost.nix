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
  users.users.charles.extraGroups = [ "immich" ];

  # Homeassistant
  virtualisation.oci-containers = {
    backend = "docker";
    containers.homeassistant = {
      volumes = [ "home-assistant:/config" ];
      environment.TZ = "Europe/Berlin";
      # Note: The image will not be updated on rebuilds, unless the version label changes
      image = "ghcr.io/home-assistant/home-assistant:stable";
      extraOptions = [ 
        # Use the host network namespace for all sockets
        #"--network=host"
        # Pass devices into the container, so Home Assistant can discover and make use of them
        #"--device=/dev/ttyACM0:/dev/ttyACM0"
      ];
      devices = [ "/dev/ttyUSB0:/dev/ttyUSB0" ];
    };
  };
} 

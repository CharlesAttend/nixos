{ config, pkgs, ... }:

{
  services.dawarich = {
    enable = true;
    webPort = 5435;
    localDomain = "192.168.1.118";
    configureNginx = false;
    # extraEnvFiles =
  };

  networking.firewall.allowedTCPPorts = [
    config.services.dawarich.webPort
  ];
}

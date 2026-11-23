{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.n8n = {
    enable = true;
  };
  networking.firewall.allowedTCPPorts = [
    (lib.strings.toInt config.services.n8n.environment.N8N_PORT)
  ];
}



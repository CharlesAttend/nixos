{
  config,
  lib,
  pkgs,
  ...
}:

{
services.ddns-updater = {
  enable = true;
  environment = {
    SERVER_ENABLED="no";
    CONFIG_FILEPATH = "/etc/ddns-updater/config.json";
    PERIOD = "5m";
  };
};
}

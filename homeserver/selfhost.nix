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
}

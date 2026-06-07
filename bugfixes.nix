{ config, pkgs, ... }:

{
  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10" # logseq electron deprecation https://github.com/NixOS/nixpkgs/issues/528213
  ];
}

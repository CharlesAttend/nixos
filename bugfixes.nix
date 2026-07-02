{ config, pkgs, ... }:
let
  pkgs_logseq = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/ec0c722e017dfccbb2f66a8aafbe003320266d33.tar.gz";
    sha256 = "0jws2i94asr1yish76799gmyw51dj98n8badq3snc8prifmsd3a5";
  }) { system = pkgs.stdenv.hostPlatform.system; };
in
{
  environment.systemPackages = [pkgs_logseq.logseq]; # https://github.com/NixOS/nixpkgs/issues/535206#issuecomment-4818425933
  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10" # logseq electron deprecation https://github.com/NixOS/nixpkgs/issues/528213
  ];
}

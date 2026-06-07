{ config, pkgs, ... }:

{
  security.pki.certificateFiles = [
    ./certs/bundle.crt
  ];
  environment.systemPackages = with pkgs; [
    kubectl
    kubelogin-oidc
    lens

    bun
    nodejs_24
  ];
}

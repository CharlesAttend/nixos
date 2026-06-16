{ config, pkgs, ... }:

{
  security.pki.certificateFiles = [
    ./certs/bundle.crt
  ];
  environment.systemPackages = with pkgs; [
    kubectl
    kubelogin-oidc
    lens
    kubernetes-helm

    awscli2

    bun
    nodejs_24
  ];
}

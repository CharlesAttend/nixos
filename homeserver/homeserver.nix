{ config, pkgs, ... }:

{
  nix.settings.trusted-users = [ "charles" ];
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  services.fail2ban.enable = true;
  users.users.charles.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP7ukSzyvyn8rATCSEQZD2bcoY6+WgI5bwSfL6BqIqWp charles@nixos" # desktop
  ];
  console.keyMap = "uk";
}

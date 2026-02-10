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
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKPEwFFe06EAOZWcP2kQkV8ooYf0iHx1GUugZ6AggWW2 cvin-prestataire@ina.fr"
  ];
  console.keyMap = "uk";
}

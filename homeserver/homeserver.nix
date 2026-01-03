{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    # settings = {
    #   PasswordAuthentication = false;
    #   PermitRootLogin = "no";
    # };
  };
  services.fail2ban.enable = true;
  console.keyMap = "uk";
}

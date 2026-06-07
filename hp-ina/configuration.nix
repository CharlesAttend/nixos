{ config, pkgs, ... }:

{
  imports = [
    ../base.nix
    ../daily.nix
    ../modules/hyprland/hyprland.nix
    ./hardware.nix
    ./games.nix
    ./taf.nix
    ./vpn_and_2fa.nix
    ./displaylink.nix
  ];
  programs.nix-ld.enable = true;
  # swap esc capslock
  services.udev.extraHwdb = ''
    evdev:input:b0011v0001p0001*
        KEYBOARD_KEY_3a=esc
        KEYBOARD_KEY_01=capslock

    evdev:input:b0003v19F5p3235*
        KEYBOARD_KEY_3a=esc
        KEYBOARD_KEY_01=capslock
  '';
  networking.hostName = "hp-ina";

  system.stateVersion = "25.11"; # don't touch that bro 
}

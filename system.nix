{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.grub = {
    devices = [ "nodev" ];
    efiSupport = true;
    useOSProber = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

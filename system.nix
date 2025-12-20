{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.loader.grub = {
  #   devices = [ "nodev" ];
  #   efiSupport = true;
  #   useOSProber = true;
  #   extraEntries = ''
  #     menuentry "Windows" --class windows --class os {
  #       insmod part_gpt
  #       insmod fat
  #       search --no-floppy --fs-uuid --set=root 770D-77B0
  #       chainloader /EFI/Microsoft/Boot/bootmgfw.efi
  #     }
  #   '';
  # };

  boot.loader.limine = {
    enable = true;
    secureBoot.enable = true;
    maxGenerations = 3;
    extraEntries = ''
      /Windows 10
        protocol: efi
        path: guid(0cbe6065-3880-479c-afc7-c0ab673b6ffd):/EFI/Microsoft/Boot/bootmgfw.efi
    '';
    style = {
      wallpapers = [ ];
      interface = {
        resolution = "1920x1080";
        branding = "feur";
        brandingColor = 6;
      };
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

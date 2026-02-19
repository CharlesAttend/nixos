{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_18;

  boot.loader.limine = {
    enable = true;
    secureBoot.enable = true;
    maxGenerations = 10;
    extraEntries = ''
      /Windows 10
        protocol: efi
        path: guid(0cbe6065-3880-479c-afc7-c0ab673b6ffd):/EFI/Microsoft/Boot/bootmgfw.efi
      /Arch Linux
        protocol: linux
        path: guid(0cbe6065-3880-479c-afc7-c0ab673b6ffd):/vmlinuz-linux
        cmdline: root=UUID=9cfbd369-ae55-4175-868c-1404fc362c42 rw
        module_path: guid(0cbe6065-3880-479c-afc7-c0ab673b6ffd):/initramfs-linux.img
    '';
    extraConfig = ''
      timeout: 9
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

}

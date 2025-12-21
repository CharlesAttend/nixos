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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

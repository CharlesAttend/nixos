{ config, pkgs, ... }:

{
  networking.hostName = "nixos";

  security.polkit.enable = true;
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.blueman.enable = true;
  services.printing.enable = true;


  users.users.charles = {
    isNormalUser = true;
    description = "Charles";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "i2c"
      "docker"
    ];
  };

  environment.systemPackages = with pkgs; [
    vivaldi
    vscode
    gparted
    vlc
    (pkgs.callPackage ./packages/stremio-linux-shell.nix {})
    
    logseq
    xournalpp
    anytype
    
    vesktop
    signal-desktop
    
    bluetui
    ntfs3g
    android-tools
    megasync
    pkgs.nixfmt-rfc-style
  ];
}
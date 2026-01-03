{ config, pkgs, ... }:

{
  networking.hostName = "nixos";

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    blueman.enable = true;
    printing.enable = true;
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
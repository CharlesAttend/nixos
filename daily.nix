{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vivaldi
    vscode
    gparted
    vlc
    (pkgs.callPackage ./packages/stremio-linux-shell.nix { })

    logseq
    xournalpp
    anytype

    vesktop
    signal-desktop
    teams-for-linux

    bluetui
    ntfs3g
    android-tools
    megasync
    ente-auth
    pkgs.nixfmt-rfc-style
  ];

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

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.lilex
    nerd-fonts.droid-sans-mono
  ];
}

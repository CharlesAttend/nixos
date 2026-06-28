{ config, pkgs, ... }:

{
  imports = [ ./bugfixes.nix ];

  environment.systemPackages = with pkgs; [
    kitty
    vivaldi
    vscode
    gparted
    vlc
    #(pkgs.callPackage ./packages/stremio-linux-shell.nix { })

    logseq
    xournalpp
    anytype
    (pkgs.callPackage ./packages/sunsama.nix { })
    (pkgs.callPackage ./packages/notion-electron.nix { })

    vesktop
    signal-desktop
    teams-for-linux
    beeper
    spotify

    pavucontrol
    bluetui
    ntfs3g
    android-tools
    megasync
    ente-auth
    cura-appimage

    # nvim plugins
    pkgs.nixfmt-rfc-style
  ];
  services.gnome.gnome-keyring.enable = true;
  services.gnome.gcr-ssh-agent.enable = false; # Use program.ssh.start-agent

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
    printing.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.bluetooth.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.lilex
    nerd-fonts.droid-sans-mono
  ];
}

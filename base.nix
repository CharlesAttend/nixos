{ config, pkgs, ... }:

{
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  users.users.charles = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "i2c"
      "docker"
    ];
    initialHashedPassword = "$y$j9T$2OaLLN8PsTRFwmTRgR5FK0$gvtDFywTsVDQCizdkGYMDg7jov.JhBywQ7UHZEOydL6";
  };

  networking.networkmanager.enable = true;
  # Use Quad9 for DNS
  networking.nameservers = [
    "9.9.9.9"
    "149.112.112.112"
  ];

  # CLI shell configuration
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    histSize = 10000;
    ohMyZsh.enable = true;
    ohMyZsh.plugins = [
      "git"
      "git-auto-fetch"
      "dotenv"
      "dirhistory"
      "uv"
    ];
    ohMyZsh.theme = "frisk";
    syntaxHighlighting.enable = true;
  };
  programs.starship = {
    enable = true;
    presets = [ "pastel-powerline" ];
  };
  programs.fzf.fuzzyCompletion = true;
  programs.neovim.enable = true;
  programs.ssh.startAgent = true;
  services.fwupd.enable = true;

  # Base packages
  environment.systemPackages = with pkgs; [
    wget
    curl
    killall
    ddcutil
    git
    btop
    zellij
    pay-respects # fuck cmd
    usbutils # lsusb
    uv
    sbctl # Secure boot key manager
    qwerty-fr
    gcc
    gnumake
    ffmpeg
  ];

  virtualisation.docker.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix = {
    settings.auto-optimise-store = true;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}

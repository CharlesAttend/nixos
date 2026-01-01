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

  networking.networkmanager.enable = true;

  # CLI shell configuration
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    histSize = 10000;
    ohMyZsh.enable = true;
    ohMyZsh.plugins = [ "git" "git-auto-fetch" "dotenv" "dirhistory" "uv" ];
    ohMyZsh.theme = "frisk";
    syntaxHighlighting.enable = true;
  };
  programs.starship = {
    enable = true;
    presets = ["pastel-powerline"];
  };
  programs.fzf.fuzzyCompletion = true;
  programs.neovim.enable = true;
  programs.ssh.startAgent = true;

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
  ];
  
  virtualisation.docker = {
    enable = true;
  };
  
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

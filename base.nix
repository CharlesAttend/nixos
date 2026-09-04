{ config, pkgs, ... }:

{
  imports = [ ./modules/sops.nix ];

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
  programs.gnupg.agent.enable = true;

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
    syntaxHighlighting.enable = true;
    histSize = 10000;
    ohMyZsh.enable = true;
    ohMyZsh.plugins = [
      "git"
      "git-auto-fetch"
      "dotenv"
      "dirhistory"
      "uv"
      "kubectl"
      "timer"
    ];
    ohMyZsh.theme = "frisk";
    shellAliases = {
      ll = "ls -al";
      update = "sudo nixos-rebuild switch";
      harlequina = "harlequin  --theme monokai -a trino --host trino.2ia.d.sas.ina --port 443 --user cvin --require_auth password --password $(secret-tool liookup ldap password)";
      btui = "bluetui";
      nv = "nvim .";
      vpnc = "secret-tool lookup ldap password | sudo openconnect --protocol=gp connexion.ina.fr --csd-wrapper /usr/lib/openconnect/hipreport.sh -u cvin --passwd-on-stdin";
      fullpush = "git add * && git commit -m 'fullpush' && git push";
      stfu = "shutdown now";
      dark = "~/.config/yin_yang/dark-theme.sh";
      light = "~/.config/yin_yang/light-theme.sh";
      lgit = "lazygit";
      k = "kubecolor";
    };

  };
  programs.starship = {
    enable = true;
    presets = [ "pastel-powerline" ];
  };
  programs.fzf.fuzzyCompletion = true;
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.ssh.startAgent = true;
  services.fwupd.enable = true;

  # Base packages
  environment.systemPackages = with pkgs; [
    wget
    curl
    unzip
    jq
    ncdu
    killall
    ddcutil
    git
    sops

    lazygit
    ripgrep
    fd
    ghostscript_headless # PDF render in nvim

    uv

    btop
    iotop
    zellij
    pay-respects # fuck cmd
    usbutils # lsusb
    sbctl # Secure boot key manager
    qwerty-fr
    gcc
    gnumake
    ffmpeg
    opencode
    lsof # With opencode lazyvim plugin
    claude-code
  ];

  # Python with uv only
  environment = {
    localBinInPath = true;
  };
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
    ];
  };

  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us_qwerty-fr";
    extraLayouts = {
      us_qwerty-fr = {
        description = "";
        languages = [ "eng" ];
        symbolsFile = "${pkgs.qwerty-fr}/share/X11/xkb/symbols/us_qwerty-fr";
      };
    };
  };
  hardware.i2c.enable = true; # ddcutils
  virtualisation.docker.enable = true;

  services.logind.settings.Login.HandlePowerKey = "poweroff";

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

{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  boot.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
    "i2c-nvidia_gpu"
  ];
  # Enable OpenGL
  hardware.graphics = {
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      libvdpau-va-gl
    ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  };
}

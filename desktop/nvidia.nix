{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia drisver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    
    powerManagement.enable = true;
  };
}

{ config, lib, pkgs, ... }:
{

  virtualisation.podman = {
    enableNvidia = true;
    enable = true;
  };

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = false;

    # Enable the Nvidia settings menu accessible via `nvidia-settings`.
    nvidiaSettings = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

    hardware.nvidia.prime = {
    	# Make sure to use the correct Bus ID values for your system!
    	amdgpuBusId = "PCI:74:0:0";
    	nvidiaBusId = "PCI:1:0:0";
    	offload = {
    	  enable = true;
    	  enableOffloadCmd = true;
    	};
    }; 

} 

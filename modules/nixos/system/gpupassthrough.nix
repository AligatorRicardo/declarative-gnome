{ pkgs, ...}:

let
  # Change this to match your system's CPU.
  platform = "amd";
  # Change this to specify the IOMMU ids you wrote down earlier.
  vfioIds = [ "10de:24a0" "10de:228b" ];
in 
{

      boot = {
         kernelModules = [ "kvm-${platform}" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
         kernelParams = [ "${platform}_iommu=on" "${platform}_iommu=pt" "kvm.ignore_msrs=1" "acpi_backlight=video" "acpi_osi=Linux" ];
         extraModprobeConfig = "options vfio-pci ids=${builtins.concatStringsSep "," vfioIds}";
	 blacklistedKernelModules = [
            "nvidia"
            "nvidiafb"
            "nvidia-drm"
            "nvidia-uvm"
            "nvidia-modeset"
         ];
      };

      # Add a file for looking-glass to use later. This will allow for viewing the guest VM's screen in a performant way.
      systemd.tmpfiles.rules = [
           "f /dev/shm/looking-glass 0660 theloremaster qemu-libvirtd -"
      ];

      virtualisation = {
       libvirtd = {
        enable = true;
        # Don't start any VMs automatically on boot.
        onBoot = "ignore";
        # Stop all running VMs on shutdown.
        onShutdown = "shutdown";
        qemu = {
         #package = pkgs.qemu_kvm;
         ovmf.enable = true;
         verbatimConfig = ''
         namespaces = []
         '';
         };
         };
      };
      programs.virt-manager.enable = true;
}



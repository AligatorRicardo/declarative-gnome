# Edit this configuration file to define what should be installed on your system. 

{ config, pkgs, system, inputs, stdenv, ... }:

 # Not working as of 24.11, waiting for a commit to update it.
 let acermodule = config.boot.kernelPackages.callPackage ./acer-rgb.nix {}; in

{
  imports =
    [ # Include the results of the hardware scan.
       inputs.home-manager.nixosModules.default
    ];

  # Bootloader and SystemD
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "antioch"; # Define your hostname.
  boot.initrd.luks.devices."luks-bfaa491e-daa1-48ce-922d-a71fa80bfb25".device = "/dev/disk/by-uuid/bfaa491e-daa1-48ce-922d-a71fa80bfb25"; # Encrypts my device. WARNING: COPY THIS VALUE FROM THE STOCK FILE BEFORE REBUILDING, IT MIGHT BREAK LUKS IF YOU DONT 

  # Enable OpenGL
  hardware.opengl = {
     enable = true;
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable Flakes
  nix.settings.experimental-features = [ "flakes" "nix-command" ];

  # Test
  #boot.kernelPackages = pkgs.linuxPackages_latest;

  # Set your time zone.
  time.timeZone = "America/Fortaleza";

  # Enables Hardware Firmware to fix some minor bugs. Will try disabling it
  #hardware.enableAllFirmware = true;

  # Enables my Acer RGB Keyboard to work properly, and removes boot logs.
  boot.extraModulePackages = [ acermodule ]; # Not working as of 24.11, waiting for an update.
  boot.kernelModules = [ "facer" "wmi" "sparse-keymap" "video" ];
  # Legacy code, moved to nvidia.nix.
  #boot.kernelParams = [ "quiet" "udev.log_level=3" "acpi_backlight=video" "acpi_osi=Linux" ];

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system and removes Xterm from it.
  services.xserver = {
    enable = true;
    excludePackages = [ pkgs.xterm ];
    libinput.enable = true;
  };

  # Enable SDDM as the display manager.
  services.displayManager.sddm = {
     enable = true;
     wayland.enable = true;
     theme = "${import ./sddm-theme.nix {inherit pkgs; }}";
  };

  # Enables Hyprland WM
  programs.hyprland.enable = true;
  
  # Enables GNOME Keyring
  services.gnome.gnome-keyring.enable = true;

  # Enables XDG GTK Portals 
  xdg.portal = { 
    enable = true; 
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; 
  }; 

  # Services required for Hyprpanel
  services.gvfs.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true; 
  programs.dconf.enable = true;
  

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enables Bluetooth and Blueman
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;  

  # Enables ZSH
  programs.zsh.enable = true;
 
  # Define a user account with ZSH as default shell. Don't forget to set a password
  users.users.theloremaster = {
    isNormalUser = true;
    description = "Loremaster";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "qemu-libvirtd" "disk" ];
    shell = pkgs.zsh;
    packages = with pkgs; [ pkgs.virtiofsd ];
  };

  # Enables Home-Manager for the "theloremaster" user
  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs; 
    inherit system;
    };
    users = {
    "theloremaster" = import ./home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the OpenSSH daemon.
  #services.openssh.enable = false;

  # Enables Fonts for Flatpak.
  fonts.fontDir.enable = true;

  # Disables the firewall altogether.
  networking.firewall.enable = false;

  # Enables Virt-Manager
  programs.virt-manager.enable = true;

  # 
  environment.systemPackages = with pkgs; [
      libsForQt5.qt5.qtquickcontrols2
      virt-manager
      libsForQt5.qt5.qtgraphicaleffects
  ];

  # Uses SystemD-Resolved to enable NextDNS
  services.resolved = {
       enable = true;
       extraConfig = "
         DNS=45.90.28.0#968e21.dns.nextdns.io
         DNS=2a07:a8c0::#968e21.dns.nextdns.io
         DNS=45.90.30.0#968e21.dns.nextdns.io
         DNS=2a07:a8c1::#968e21.dns.nextdns.io
         DNSOverTLS=yes
         DNSSEC=false
       ";
  };

  # This value determines the NixOS release when it was installed.
  # Do not change this under no circunstance wittout reading the news.
  system.stateVersion = "24.05";

}

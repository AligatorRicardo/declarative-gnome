# Edit this configuration file to define what should be installed on your system. 

{ config, pkgs, inputs, catppuccinifier, ... }:

 let acermodule = config.boot.kernelPackages.callPackage ./acer-rgb.nix {}; in

{
  imports =
    [ # Include the results of the hardware scan.
       inputs.home-manager.nixosModules.default
    ];

  # Bootloader and SystemD
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;

  networking.hostName = "snowpenguin"; # Define your hostname.
  boot.initrd.luks.devices."luks-250ac524-4957-4756-80a9-fb3d593497af".device = "/dev/disk/by-uuid/250ac524-4957-4756-80a9-fb3d593497af"; # Encrypts my harddrive, THIS WILL CHANGE ON FUTURE INSTALLATIONS

  # Enable networking
  networking.networkmanager = {
     enable = true;
  };

  # Enable Flakes
  nix.settings.experimental-features = [ "flakes" "nix-command" ];

  # Set your time zone.
  time.timeZone = "America/Fortaleza";

  # Enables Hardware Firmware to fix some minor bugs
  hardware.enableAllFirmware = true;

  # Enables my Acer RGB Keyboard to work properly, and removes boot logs.
  boot.extraModulePackages = [ acermodule ];
  boot.kernelModules = [ "facer" "wmi" "sparse-keymap" "video" ];
  boot.kernelParams = [ "quiet" "udev.log_level=3" "acpi_backlight=video" "acpi_osi=Linux" ];

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
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Delete all bloatware that GNOME ships by default ( A lot of stuff, lol)
  environment.gnome.excludePackages = (with pkgs; [
  gnome-photos
  gnome-tour
  gnome-console
  ]) ++ (with pkgs.gnome; [
  cheese # webcam tool
  gnome-music
  gedit # text editor
  epiphany # web browser
  geary # email reader
  evince # document viewer
  gnome-characters
  totem # video player
  tali # poker game
  iagno # go game
  hitori # sudoku game
  atomix # puzzle game
  gnome-shell-extensions
  ]);

  # Enables Dconf for a declarative GNOME setup 
  programs.dconf.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "br";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enables Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Enables ZSH
  programs.zsh.enable = true;
 
  # Define a user account with ZSH as default shell. Don't forget to set a password
  users.users.theloremaster = {
    isNormalUser = true;
    description = "Loremaster";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  # Enables Home-Manager for the "theloremaster" user
  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs catppuccinifier;};
    users = {
    "theloremaster" = import ./home.nix;
    };
  };

  # Enables GSConnect
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  # Enables Wayland electron support
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
 
  # Sets up Kitty as default terminal
  environment.sessionVariables.TERMINAL = "kitty";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Disables the firewall altogether.
  networking.firewall.enable = false;

  # Enables Virt-Manager
  programs.virt-manager.enable = true;

  # Enables NextDNS
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
  system.stateVersion = "23.11";

}

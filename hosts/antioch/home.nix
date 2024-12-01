{ config, pkgs, inputs, system, ... }:
{
  imports = [
  inputs.self.outputs.homeManagerModules.antioch
  ];

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "theloremaster";
  home.homeDirectory = "/home/theloremaster";

  # This value determines the Home Manager release that your configuration is
  # compatible with. You should not change this value, even after updating
  home.stateVersion = "24.05";

  # Enables unfree packages (Even though they were already enabled before lol)
  nixpkgs.config =  { allowUnfree = true; };

  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = [
     pkgs.hyprpanel
     pkgs.hyprpicker
     pkgs.xfce.thunar
     pkgs.xfce.thunar-volman
     pkgs.xfce.thunar-archive-plugin
     pkgs.xarchiver
     pkgs.gnome.file-roller
     pkgs.libnotify
     pkgs.libgtop
     pkgs.onlyoffice-bin
     pkgs.gowall
     pkgs.xdg-user-dirs
     pkgs.hyprlock
     pkgs.hypridle
     pkgs.snapshot
     pkgs.p7zip
     pkgs.unrar
  ];

   # This is the primary way to manage plain files with the through 'home.file'.
   home.file = { 
   };

   dconf.settings = {
     "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
     };
   };

   # Home Manager can also manage your environment variables through'home.sessionVariables'.
   home.sessionVariables = {
     EDITOR = "nvim";
     NIXOS_OZONE_WL=1;
     QT_QPA_PLATFORM = "wayland"; 
     QT_QPA_PLATFORMTHEME = "qt5ct";
   };  

   # Let Home Manager install and manage itself.
   programs.home-manager.enable = true;

}

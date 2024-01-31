{ config, inputs, pkgs, ... }:

{
 
  imports = [
  inputs.self.outputs.homeManagerModules.snowpenguin
  ];

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "theloremaster";
  home.homeDirectory = "/home/theloremaster";

  # This value determines the Home Manager release that your configuration is
  # compatible with. You should not change this value, even after updating
  home.stateVersion = "23.11";

  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = [
    pkgs.lf
    pkgs.kitty
    pkgs.activitywatch
    pkgs.aw-server-rust
    pkgs.gh
    pkgs.github-desktop
    pkgs.distrobox
   ];

  # This is the primary way to manage plain files with the through 'home.file'.
  home.file = {
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

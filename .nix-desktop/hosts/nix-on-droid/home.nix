{ config, lib, pkgs, inputs, ... }:

{
  # Read the changelog before changing this value
  home.stateVersion = "23.05";

  imports = [ inputs.self.outputs.homeManagerModules.nix-on-droid ];
  
  home.packages = [
    pkgs.lf
    pkgs.gh    
    pkgs.neovim 
  ];

}

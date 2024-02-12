{ inputs, spicetify-nix, config, lib, pkgs, ... }:

let
spicePkgs = spicetify-nix.packages.${pkgs.system}.snowpenguin;
in 
{
  # allow spotify to be installed if you don't have unfree enabled already
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "spotify" ];

  # import the flake's module for your system
  imports = [ inputs.spicetify-nix.homeManagerModule ];

  # configure spicetify :)
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin-mocha;
    colorScheme = "mocha";
    enabledExtensions = with spicePkgs.extensions; [
    ];
  };
}

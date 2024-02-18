{ config, pkgs, inputs, ...}:
{

  imports = [
     # GUI Apps and their configurations
     ./gnome.nix
     ./kitty.nix
     ./theming.nix
     ./vscodium.nix
     # TUI Apps and their configurations
     ./neovim.nix
     ./lf.nix
     ./zsh.nix
     ./git.nix
     # Importing Home Manager modules from Flakes
  ];

}

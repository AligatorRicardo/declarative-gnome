{ config, pkgs, inputs, ...}:
{

  imports = [
     # TUI Apps and their configurations
     ./neovim.nix
     ./lf.nix
     ./zsh.nix
     ./git.nix
  ];

}

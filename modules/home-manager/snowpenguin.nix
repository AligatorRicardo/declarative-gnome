{ config, pkgs, inputs, ...}:
{

  imports = [
     # Desktop configurations
     ./desktop/gnome.nix
     ./desktop/theming.nix
     # Apps and their configurations
     ./apps/neovim.nix
     ./apps/lf.nix
     ./apps/kitty.nix
     # Shell and it's configuration
     ./shell/zsh.nix
     ./shell/git.nix
  ];

}

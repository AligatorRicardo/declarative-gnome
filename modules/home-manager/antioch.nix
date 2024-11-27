{ config, pkgs, inputs, ...}:
{

  imports = [
     # Desktop
     ./desktop/hyprland.nix
     ./desktop/hyprpaper.nix
     ./desktop/theming.nix
     ./desktop/rofi.nix
     {nixpkgs.overlays = [inputs.hyprpanel.overlay];}
     # Apps and their configurations
     ./apps/neovim.nix
     ./apps/lf.nix
     ./apps/kitty.nix
     # Shell and their configuration
     ./shell/zsh.nix
     ./shell/git.nix
  ];

}

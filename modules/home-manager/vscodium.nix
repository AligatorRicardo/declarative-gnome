{ config, pkgs, inputs, ...}:
{

   programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        extensions = [
	     pkgs.vscode-extensions.catppuccin.catppuccin-vsc
	     pkgs.vscode-extensions.catppuccin.catppuccin-vsc-icons
	];
   };

}

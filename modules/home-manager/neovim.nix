{ config, pkgs, inputs, ...}:
{

 imports = [ inputs.nixvim.homeManagerModules.nixvim ];

 programs.nixvim = {
    enable = true;

     colorschemes.catppuccin = {
       enable = true;
       flavour = "mocha";
       transparentBackground = true;
     };
     plugins = {
       bufferline.enable = true;
       lsp.enable = true;
     };
     extraPlugins = with pkgs.vimPlugins; [
       nvim-cmp
    ];
 };

}

{ config, pkgs, inputs, ...}:
{

 imports = [ inputs.nixvim.homeManagerModules.nixvim ];

 programs.nixvim = {
    enable = true;

     colorschemes.gruvbox = {
       enable = true;
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

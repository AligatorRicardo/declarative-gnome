{

  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin = {
    enable = true;
    flavour = "mocha";
    transparentBackground = true;
    };
    plugins.bufferline.enable = true;
  };

}

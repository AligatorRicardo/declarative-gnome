{

   programs.kitty = {
      enable = true;
      theme = "Gruvbox Dark";
      shellIntegration.enableZshIntegration = true;
      extraConfig = ''
       tab_bar_min_tabs            1
       tab_bar_edge                bottom
       tab_bar_style               powerline
       tab_powerline_style         slanted
       tab_title_template          {title}{' :{}:'.format(num_windows) if num_windows > 1 else ""}
       background_opacity 0.9
      '';
   };

}

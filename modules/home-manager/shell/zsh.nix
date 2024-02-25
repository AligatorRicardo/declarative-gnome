{ pkgs, ...}:
{

   # Fonts for better Powerlevel10k experience
   home.packages = with pkgs; [
   nerdfonts
   meslo-lgs-nf
   ]; 

  programs.zsh = {
       enable = true;
       enableCompletion = true;
       enableAutosuggestions = true;
       syntaxHighlighting.enable = true;
       dotDir = ".config/zsh";
       
      localVariables = { 
       ZSH_DISABLE_COMPFIX = "true"; # Fixes Distrobox/VSCodium wrong shell warning
      };

      initExtra = '' # Enables Powerlevel10k, and setups .p10k.zsh
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme  
      test -f ~/.config/zsh/.p10k.zsh && source ~/.config/zsh/.p10k.zsh  
      '';

       oh-my-zsh = { # Install minor packages from Oh My Zsh, should not be necessary in a long run.
         enable = true;
         plugins = [ "git" ];
       };
  };

}


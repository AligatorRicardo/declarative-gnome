{ pkgs, config, ...}:
{

dconf.settings = {
    "org/gnome/shell" = {
       favorite-apps = [
         "io.gitlab.librewolf-community.desktop"
         "org.gnome.Nautilus.desktop"
         "kitty.desktop"
	 "de.haeckerfelix.Fragments.desktop"
	 "md.obsidian.Obsidian.desktop"
	 "org.inkscape.Inkscape.desktop"
	 "org.gimp.GIMP.desktop"
	 "com.spotify.Client.desktop"
	 "io.github.spacingbat3.webcord.desktop"
	 "com.valvesoftware.Steam.desktop"
	 "org.onlyoffice.desktopeditors.desktop"
	 "net.lutris.Lutris.desktop"
	 "com.heroicgameslauncher.hgl.desktop"
	 "com.usebottles.bottles.desktop"
	 "io.freetubeapp.FreeTube.desktop"
	 "com.github.johnfactotum.Foliate.desktop"
	 "net.lugsole.bible_gui.desktop"
       ];
    
       "disable-user-extensions" = false;
       
       enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "dash-to-dock@micxgx.gmail.com"
        "paperwm@paperwm.github.com"
        "arcmenu@arcmenu.com"
        "blur-my-shell@aunetx"
        "gsconnect@andyholmes.github.io"        
        "clipboard-indicator@tudmotu.com"
        "caffeine@patapon.info" 
        "gmind@tungstnballon.gitlab.com"
        "appindicatorsupport@rgcjonas.gmail.com"
       ];

    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/shell/extensions/paperwm" = {
       use-default-background = true;
    };

    "org/gnome/shell/extensions/user-theme" = {
        name = "Catppuccin-Mocha-Standard-Mauve-Dark";
    };
 
};

    home.packages = with pkgs; [
      gnomeExtensions.dash-to-dock
      gnomeExtensions.paperwm
      gnomeExtensions.blur-my-shell
      gnomeExtensions.arcmenu
      #gsconnect (Already installed in system)
      gnomeExtensions.caffeine
      gnomeExtensions.clipboard-indicator
      gnomeExtensions.gamemode-indicator-in-system-settings
      gnomeExtensions.appindicator
      gnomeExtensions.user-themes
      gnome.gnome-tweaks
    ];


}

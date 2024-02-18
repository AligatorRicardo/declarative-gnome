{ pkgs, config, ...}:


let
  wallpaper = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/AligatorRicardo/personal-wallpapers/main/catppuccin/mocha-hald1_upscayl.png";
    sha256 = "1qq6ykvwym9kl2a86j69vx8pw8nx9bd454j6q57n9lnskgap96sv";
  };
in

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
	"batterytime@typeof.pw"
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

    "org/gnome/desktop/peripherals/touchpad" = {
       tap-to-click = true;
    };

    "org/gnome/desktop/background" = {
      picture-uri-dark = wallpaper;
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
      gnomeExtensions.appindicator
      gnomeExtensions.user-themes
      gnomeExtensions.battery-time-2
      gnome.gnome-tweaks
    ];


}

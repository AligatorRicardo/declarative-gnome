{ config, pkgs, ...}:
{

  services.flatpak = {
     enable = true;
     update.onActivation = true;
     remotes = [
       { name = "flathub"; location = "https://flathub.org/repo/flathub.flatpakrepo"; }
       { name = "flathub-beta"; location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo"; }
       { name = "launcher.moe"; location = "https://gol.launcher.moe/gol.launcher.moe.flatpakrepo"; }
     ];
     packages = [
       "io.gitlab.librewolf-community"
       "org.onlyoffice.desktopeditors"
       "io.github.spacingbat3.webcord"
       "com.spotify.Client"
       "md.obsidian.Obsidian"
       "io.github.celluloid_player.Celluloid"
       { appId = "org.gimp.GIMP"; origin = "flathub-beta";  }
       "com.github.johnfactotum.Foliate"
       "net.lugsole.bible_gui"
       "de.haeckerfelix.Fragments"
       "org.inkscape.Inkscape"
       "io.freetubeapp.FreeTube"
       "net.lutris.Lutris"
       "com.valvesoftware.Steam"
       "io.github.Foldex.AdwSteamGtk"
       "com.heroicgameslauncher.hgl"
       "com.usebottles.bottles"
       "org.prismlauncher.PrismLauncher"
       "hu.kramo.Cartridges"
       { appId = "moe.launcher.an-anime-game-launcher"; origin = "launcher.moe";  }
       "com.github.tchx84.Flatseal"
       "com.vysp3r.ProtonPlus"
       "org.upscayl.Upscayl"
     ];
     overrides = {
        
	global = {
           Context.sockets = ["wayland" "!x11" "!fallback-x11"];
	   

	   Environment = {
	   GTK_THEME = "Catppuccin-Mocha-Standard-Mauve-Dark";
	   ICON_THEME = "Tela-purple-dark";
           };

	   Context.filesystems = [
           "/home/theloremaster/.themes"
	   "/home/theloremaster/.icons"
	   "/home/theloremaster/GamingSpace/Pokémon\ Essentials/"
	   ];

	};

        "org.onlyoffice.desktopeditors".Context.sockets = ["x11"];          "com.spotify.Client".Context.sockets = ["x11"];
	"com.valvesoftware.Steam".Context.sockets = ["x11"];
        "net.lutris.Lutris".Context.sockets = ["x11"];
	"org.prismlauncher.PrismLauncher".Context.sockets = ["x11"];
	"com.heroicgameslauncher.hgl".Context.sockets = ["x11"];
	"com.usebottles.bottles".Context.sockets = ["x11"];        
     };
 };

}

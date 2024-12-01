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
       "com.spotify.Client"
       "md.obsidian.Obsidian"
       "io.github.celluloid_player.Celluloid"
       { appId = "org.gimp.GIMP"; origin = "flathub-beta";  }
       { appId = "moe.launcher.an-anime-game-launcher"; origin = "launcher.moe"; }
       "com.github.johnfactotum.Foliate"
       "net.lutris.Lutris"
       "io.github.Foldex.AdwSteamGtk"
       "de.haeckerfelix.Fragments"
       "com.usebottles.bottles"
       "org.prismlauncher.PrismLauncher"
       "hu.kramo.Cartridges"
       "org.upscayl.Upscayl"
       "com.vysp3r.ProtonPlus"
       "org.ryujinx.Ryujinx"
       "org.libretro.RetroArch"
       "org.gnome.Boxes"
     ];
    overrides = { };
  };

}

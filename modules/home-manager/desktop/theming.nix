{ pkgs, ...}:
{

  gtk.enable = true;
  gtk.cursorTheme.package = pkgs.capitaine-cursors-themed;
  gtk.cursorTheme.name = "Capitaine Cursors (Gruvbox)";
  gtk.theme.package = pkgs.gruvbox-gtk-theme;
  gtk.theme.name = "Gruvbox-Dark";
  gtk.iconTheme.package = pkgs.gruvbox-plus-icons;
  gtk.iconTheme.name = "Gruvbox-Plus-Dark";

}

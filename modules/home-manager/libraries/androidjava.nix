{ pkgs, ...}:
{

  home.packages = with pkgs; [
     kotlin
     openjdk19
     android-tools
     scrcpy
  ];

}

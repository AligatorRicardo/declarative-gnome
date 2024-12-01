{ pkgs }:

let
  imgLink = "https://github.com/yhanruzai/snowpenguin/blob/snowpenguin/modules/home-manager/desktop/wallpapers/Background.jpg";

  image = pkgs.fetchurl {
    url = imgLink;
    sha256 = "sha256-+1fYPw3VPkwtz4U8GRHFcG6s+EpYmFMYNfweoMdgWLQ=";
  };
in
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    cd $out/
    rm Background.jpg
    cp -r ${image} $out/Background.jpg
   '';
}

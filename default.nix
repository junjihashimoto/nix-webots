{ pkgs ? import <nixpkgs> {}
}:
with pkgs;
let version = "R2020a-rev1";
in
pkgs.stdenv.mkDerivation rec {
  name = "webots-${version}";
  inherit version;

  src = fetchurl {
    url = "https://github.com/cyberbotics/webots/releases/download/R2020a-rev1/webots-R2020a-rev1-x86-64.tar.bz2";
    sha256 = "1riiqlmf9a30fz6bw5xaanshgs00lv72igrqzbp1d7z7gzm0n6xd";
  };
  dontConfigure = true;
  buildPhase = ":";
  installPhase = ''
    mkdir $out
    cp -a {bin,docs,include,lib,projects,resources,scripts,webots} $out/
    pushd $out/bin
    ln -s ../webots
    popd
  '';

  dontStrip = true;

  meta = with stdenv.lib; {
    description = "webots";
    homepage = https://cyberbotics.com/;
    license = licenses.asl20;
    platforms = with platforms; linux ++ darwin;
  };
}

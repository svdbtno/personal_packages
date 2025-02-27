{ stdenv, pkgs }:

stdenv.mkDerivation rec {
  name = "wildfly-${version}";
  version = "35.0.0";
  src = pkgs.fetchurl{
    url="https://github.com/wildfly/wildfly/releases/download/35.0.0.Final/wildfly-preview-35.0.0.Final.tar.gz";
    sha256="6kFVvLtWnfGyvysONvBDa/YuMd/tbSeRANTrKL2/sLE=";
  };
  unpackPhase = ''
    tar xzf $src
    mv wildfly-* wildfly
  '';
  propegatedBuildInputs = [ pkgs.jdk17 ];
  installPhase = "
    cp -r wildfly $out/
    chmod +x $out/bin/standalone.sh
  ";
  nativeBuildInputs = [ pkgs.makeWrapper ];

  postFixup='' 
    echo "wrapping using ${pkgs.jdk17}/bin/java"
    wrapProgram $out/bin/standalone.sh \
      --set JAVA ${pkgs.jdk17}/bin/java
  '';
}

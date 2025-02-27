{ stdenv, pkgs }:

stdenv.mkDerivation rec {
  name = "wildfly-${version}";
  version = "35.0.0";
  src = fetchFromGithub{
    owner="wildfly";
    repo="wildfly";
    rev="35.0.0.Final";
    sha256="17sbd9kxbn5xvh2fq7n9ivv4dr16871y8bzxrni7picls61fmwpl";
  };
  propegatedBuildInputs = [ pkgs.jdk17 ];
  installPhase = "
    mkdir -p $out/bin
    cp -r $src $out/
    ln -s $out/wildfly/bin/standalone.sh $out/bin/wildfly
  ";
}

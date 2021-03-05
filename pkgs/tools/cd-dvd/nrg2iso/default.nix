{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "nrg2iso";
  version = "0.4";

  src = fetchurl {
    url = "http://gregory.kokanosky.free.fr/v4/linux/${pname}-${version}.tar.gz";
    sha256 = "18sam7yy50rbfhjixwd7wx7kmfn1x1y5j80vwfxi5v408s39s115";
  };

  installPhase = ''
    mkdir -pv $out/bin/
    cp -v nrg2iso $out/bin/nrg2iso
  '';

  meta = with stdenv.lib; {
    description = "A linux utils for converting CD (or DVD) image generated by Nero Burning Rom to ISO format";
    homepage = "http://gregory.kokanosky.free.fr/v4/linux/nrg2iso.en.html";
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
}

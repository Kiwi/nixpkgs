{ stdenv
, fetchFromGitHub
, desktop-file-utils
, libpng
, pkgconfig
, SDL
, freetype
, zlib
}:

stdenv.mkDerivation rec {

  pname = "caprice32";
  version = "4.6.0";

  src = fetchFromGitHub {
    repo = "caprice32";
    rev = "v${version}";
    owner = "ColinPitrat";
    sha256 = "0hng5krwgc1h9bz1xlkp2hwnvas965nd7sb3z9mb2m6x9ghxlacz";
  };

  nativeBuildInputs = [ desktop-file-utils pkgconfig ];
  buildInputs = [ libpng SDL freetype zlib ];

  makeFlags = [
    "APP_PATH=${placeholder "out"}/share/caprice32"
    "RELEASE=1"
    "DESTDIR=${placeholder "out"}"
    "prefix=/"
  ];

  postInstall = ''
    mkdir -p $out/share/icons/
    mv $out/share/caprice32/resources/freedesktop/caprice32.png $out/share/icons/
    mv $out/share/caprice32/resources/freedesktop/emulators.png $out/share/icons/

    desktop-file-install --dir $out/share/applications \
      $out/share/caprice32/resources/freedesktop/caprice32.desktop

    desktop-file-install --dir $out/share/desktop-directories \
      $out/share/caprice32/resources/freedesktop/Emulators.directory

    install -Dm644 $out/share/caprice32/resources/freedesktop/caprice32.menu -t $out/etc/xdg/menus/applications-merged/
  '';

  meta = with stdenv.lib; {
    description = "A complete emulation of CPC464, CPC664 and CPC6128";
    homepage = "https://github.com/ColinPitrat/caprice32";
    license = licenses.gpl2;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}

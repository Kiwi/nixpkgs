{ stdenv
, fetchFromGitHub
, mpfr
, libxml2
, intltool
, pkgconfig
, doxygen
, autoreconfHook
, readline
, libiconv
, icu
, curl
, gnuplot
, gettext
}:

stdenv.mkDerivation rec {
  pname = "libqalculate";
  version = "3.14.0";

  src = fetchFromGitHub {
    owner = "qalculate";
    repo = "libqalculate";
    rev = "v${version}";
    sha256 = "1j4sr9s7152xmci677pnz64spv8s3ia26fbp5cqx8ydv7swlivh2";
  };

  outputs = [ "out" "dev" "doc" ];

  nativeBuildInputs = [ intltool pkgconfig autoreconfHook doxygen ];
  buildInputs = [ curl gettext libiconv readline ];
  propagatedBuildInputs = [ libxml2 mpfr icu ];
  enableParallelBuilding = true;

  preConfigure = ''
    intltoolize -f
  '';

  patchPhase = ''
    substituteInPlace libqalculate/Calculator-plot.cc \
      --replace 'commandline = "gnuplot"' 'commandline = "${gnuplot}/bin/gnuplot"' \
      --replace '"gnuplot - ' '"${gnuplot}/bin/gnuplot - '
  '' + stdenv.lib.optionalString stdenv.cc.isClang ''
    substituteInPlace src/qalc.cc \
      --replace 'printf(_("aborted"))' 'printf("%s", _("aborted"))'
  '';

  preBuild = ''
    pushd docs/reference
    doxygen Doxyfile
    popd
  '';

  meta = with stdenv.lib; {
    description = "An advanced calculator library";
    homepage = "http://qalculate.github.io";
    maintainers = with maintainers; [ gebner ];
    license = licenses.gpl2Plus;
    platforms = platforms.all;
  };
}

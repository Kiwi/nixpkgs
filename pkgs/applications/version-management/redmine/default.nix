{ stdenv, fetchurl, bundlerEnv, ruby }:

let
  version = "4.1.1";
  rubyEnv = bundlerEnv {
    name = "redmine-env-${version}";

    inherit ruby;
    gemdir = ./.;
    groups = [ "development" "ldap" "markdown" "minimagick" "openid" "test" ];
  };
in
stdenv.mkDerivation rec {
  pname = "redmine";
  inherit version;

  src = fetchurl {
    url = "https://www.redmine.org/releases/${pname}-${version}.tar.gz";
    sha256 = "1nndy5hz8zvfglxf1f3bsb1pkrfwinfxzkdan1vjs3rkckkszyh5";
  };

  buildInputs = [ rubyEnv rubyEnv.wrappedRuby rubyEnv.bundler ];

  # taken from https://www.redmine.org/issues/33784
  # can be dropped when the upstream bug is closed and the fix is present in the upstream release
  patches = [ ./0001-python3.patch ];

  buildPhase = ''
    mv config config.dist
    mv public/themes public/themes.dist
  '';

  installPhase = ''
    mkdir -p $out/share
    cp -r . $out/share/redmine
    for i in config files log plugins public/plugin_assets public/themes tmp; do
      rm -rf $out/share/redmine/$i
      ln -fs /run/redmine/$i $out/share/redmine/$i
    done
  '';

  meta = with stdenv.lib; {
    homepage = "https://www.redmine.org/";
    platforms = platforms.linux;
    maintainers = [ maintainers.aanderse ];
    license = licenses.gpl2;
  };
}

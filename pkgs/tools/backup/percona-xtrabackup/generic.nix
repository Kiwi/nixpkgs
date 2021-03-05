{ stdenv
, fetchFromGitHub
, bison
, boost
, cmake
, makeWrapper
, pkgconfig
, curl
, cyrus_sasl
, libaio
, libedit
, libev
, libevent
, libgcrypt
, libgpgerror
, lz4
, ncurses
, numactl
, openssl
, protobuf
, valgrind
, xxd
, zlib
, perlPackages
, version
, sha256
, extraPatches ? [ ]
, extraPostInstall ? ""
, ...
}:

stdenv.mkDerivation rec {
  pname = "percona-xtrabackup";
  inherit version;

  src = fetchFromGitHub {
    owner = "percona";
    repo = "percona-xtrabackup";
    rev = "${pname}-${version}";
    inherit sha256;
  };

  nativeBuildInputs = [ bison boost cmake makeWrapper pkgconfig ];

  buildInputs = [
    curl
    cyrus_sasl
    libaio
    libedit
    libev
    libevent
    libgcrypt
    libgpgerror
    lz4
    ncurses
    numactl
    openssl
    protobuf
    valgrind
    xxd
    zlib
  ] ++ (with perlPackages; [ perl DBI DBDmysql ]);

  patches = extraPatches;

  cmakeFlags = [
    "-DMYSQL_UNIX_ADDR=/run/mysqld/mysqld.sock"
    "-DBUILD_CONFIG=xtrabackup_release"
    "-DINSTALL_MYSQLTESTDIR=OFF"
    "-DWITH_BOOST=system"
    "-DWITH_CURL=system"
    "-DWITH_EDITLINE=system"
    "-DWITH_LIBEVENT=system"
    "-DWITH_LZ4=system"
    "-DWITH_PROTOBUF=system"
    "-DWITH_SASL=system"
    "-DWITH_SSL=system"
    "-DWITH_ZLIB=system"
    "-DWITH_VALGRIND=ON"
    "-DWITH_MAN_PAGES=OFF"
    "-DCMAKE_SKIP_BUILD_RPATH=OFF" # To run libmysql/libmysql_api_test during build.
  ];

  postInstall = ''
    wrapProgram "$out"/bin/xtrabackup --prefix PERL5LIB : $PERL5LIB
    rm -r "$out"/lib/plugin/debug
  '' + extraPostInstall;

  meta = with stdenv.lib; {
    description = "Non-blocking backup tool for MySQL";
    homepage = "http://www.percona.com/software/percona-xtrabackup";
    license = licenses.lgpl2;
    platforms = platforms.linux;
    maintainers = with maintainers; [ izorkin ];
  };
}

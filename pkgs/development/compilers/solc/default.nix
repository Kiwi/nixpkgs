{ gccStdenv
, fetchzip
, boost
, cmake
, ncurses
, python3
, coreutils
, z3Support ? true
, z3 ? null
, cvc4Support ? true
, cvc4 ? null
, cln ? null
, gmp ? null
}:

# compiling source/libsmtutil/CVC4Interface.cpp breaks on clang on Darwin,
# general commandline tests fail at abiencoderv2_no_warning/ on clang on NixOS
let stdenv = gccStdenv; in

assert z3Support -> z3 != null && stdenv.lib.versionAtLeast z3.version "4.6.0";
assert cvc4Support -> cvc4 != null && cln != null && gmp != null;

let
  jsoncppVersion = "1.9.4";
  jsoncppUrl = "https://github.com/open-source-parsers/jsoncpp/archive/${jsoncppVersion}.tar.gz";
  jsoncpp = fetchzip {
    url = jsoncppUrl;
    sha256 = "0qnx5y6c90fphl9mj9d20j2dfgy6s5yr5l0xnzid0vh71zrp6jwv";
  };
in
stdenv.mkDerivation rec {

  pname = "solc";
  version = "0.7.4";

  # upstream suggests avoid using archive generated by github
  src = fetchzip {
    url = "https://github.com/ethereum/solidity/releases/download/v${version}/solidity_${version}.tar.gz";
    sha256 = "02261l54jdbvxk612z7zsyvmchy1rx4lf27b3f616sd7r56krpkg";
  };

  postPatch = ''
    substituteInPlace cmake/jsoncpp.cmake \
      --replace "${jsoncppUrl}" ${jsoncpp}
  '';

  cmakeFlags = [
    "-DBoost_USE_STATIC_LIBS=OFF"
  ] ++ stdenv.lib.optionals (!z3Support) [
    "-DUSE_Z3=OFF"
  ] ++ stdenv.lib.optionals (!cvc4Support) [
    "-DUSE_CVC4=OFF"
  ];

  nativeBuildInputs = [ cmake ];
  buildInputs = [ boost ]
    ++ stdenv.lib.optionals z3Support [ z3 ]
    ++ stdenv.lib.optionals cvc4Support [ cvc4 cln gmp ];
  checkInputs = [ ncurses python3 ];

  # Test fails on darwin for unclear reason
  doCheck = stdenv.hostPlatform.isLinux;

  checkPhase = ''
    while IFS= read -r -d ''' dir
    do
      LD_LIBRARY_PATH=$LD_LIBRARY_PATH''${LD_LIBRARY_PATH:+:}$(pwd)/$dir
      export LD_LIBRARY_PATH
    done <   <(find . -type d -print0)

    pushd ..
    # IPC tests need aleth avaliable, so we disable it
    sed -i "s/IPC_ENABLED=true/IPC_ENABLED=false\nIPC_FLAGS=\"--no-ipc\"/" ./scripts/tests.sh
    for i in ./scripts/*.sh ./scripts/*.py ./test/*.sh; do
      patchShebangs "$i"
    done
    TERM=xterm ./scripts/tests.sh
    popd
  '';

  meta = with stdenv.lib; {
    description = "Compiler for Ethereum smart contract language Solidity";
    homepage = "https://github.com/ethereum/solidity";
    license = licenses.gpl3;
    platforms = with platforms; linux ++ darwin;
    maintainers = with maintainers; [ dbrock akru lionello sifmelcara ];
    inherit version;
  };
}

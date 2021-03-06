{ lib, stdenv, fetchFromGitHub, autoreconfHook }:

let
  version = "0.196";
in
stdenv.mkDerivation {
  pname = "metamath";
  inherit version;

  buildInputs = [ autoreconfHook ];

  src = fetchFromGitHub {
    owner = "metamath";
    repo = "metamath-exe";
    rev = "v${version}";
    sha256 = "sha256-/ofH5fq7lUxbbRBAczsLNG3UPsOMbCdcxkB3el5OPcU=";
  };

  meta = with lib; {
    description = "Interpreter for the metamath proof language";
    longDescription = ''
      The metamath program is an ASCII-based ANSI C program with a command-line
      interface. It was used (along with mmj2) to build and verify the proofs
      in the Metamath Proof Explorer, and it generated its web pages. The *.mm
      ASCII databases (set.mm and others) are also included in this derivation.
    '';
    homepage = "http://us.metamath.org";
    downloadPage = "http://us.metamath.org/#downloads";
    license = licenses.gpl2Only;
    maintainers = [ maintainers.taneb ];
    platforms = platforms.all;
  };
}

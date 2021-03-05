{ lib, fetchFromGitHub, crystal_0_31, coreutils, shards, makeWrapper, which }:

let crystal = crystal_0_31;

in
crystal.buildCrystalPackage rec {
  pname = "scry";
  version = "0.8.1";

  src = fetchFromGitHub {
    owner = "crystal-lang-tools";
    repo = pname;
    rev = "v${version}";
    sha256 = "0ii4k9l3dgm1c9lllc8ni9dar59lrxik0v9iz7gk3d6v62wwnq79";
  };

  # we are already testing for this, so we can ignore the failures
  postPatch = ''
    rm spec/scry/executable_spec.cr
  '';

  format = "crystal";

  nativeBuildInputs = [ makeWrapper ];

  shardsFile = ./shards.nix;

  crystalBinaries.scry.src = "src/scry.cr";

  postFixup = ''
    wrapProgram $out/bin/scry \
      --prefix PATH : ${lib.makeBinPath [ crystal coreutils ]}
  '';

  # the binary doesn't take any arguments, so this will hang
  doInstallCheck = false;

  meta = with lib; {
    description = "Code analysis server for the Crystal programming language";
    homepage = "https://github.com/crystal-lang-tools/scry";
    license = licenses.mit;
    maintainers = with maintainers; [ peterhoeg Br1ght0ne ];
  };
}

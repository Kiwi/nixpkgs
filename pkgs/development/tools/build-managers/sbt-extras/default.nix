{ lib
, stdenv
, fetchFromGitHub
, which
, curl
, makeWrapper
, jdk
, writeScript
, common-updater-scripts
, cacert
, git
, nixfmt
, nix
, jq
, coreutils
, gnused
}:

stdenv.mkDerivation rec {
  pname = "sbt-extras";
  rev = "2c582cdbb37dd487bf2140010ddd2e20f3c1394e";
  version = "2021-03-03";

  src = fetchFromGitHub {
    owner = "paulp";
    repo = "sbt-extras";
    inherit rev;
    sha256 = "1j4j46gzw05bis7akvzfdj36xdwxcabq66wyf917z8vsy31vvajp";
  };

  dontBuild = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    substituteInPlace bin/sbt --replace 'declare java_cmd="java"' 'declare java_cmd="${jdk}/bin/java"'

    install bin/sbt $out/bin

    wrapProgram $out/bin/sbt --prefix PATH : ${lib.makeBinPath [ which curl ]}

    runHook postInstall
  '';

  doInstallCheck = true;
  installCheckPhase = ''
    $out/bin/sbt -h >/dev/null
  '';

  passthru.updateScript = writeScript "update.sh" ''
     #!${stdenv.shell}
     set -xo errexit
     PATH=${
       lib.makeBinPath [
         common-updater-scripts
         curl
         cacert
         git
         nixfmt
         nix
         jq
         coreutils
         gnused
       ]
     }
    oldVersion="$(nix-instantiate --eval -E "with import ./. {}; lib.getVersion ${pname}" | tr -d '"')"
     latestSha="$(curl -L -s https://api.github.com/repos/paulp/sbt-extras/commits\?sha\=master\&since\=$oldVersion | jq -r '.[0].sha')"
    if [ ! "null" = "$latestSha" ]; then
       nixpkgs="$(git rev-parse --show-toplevel)"
       default_nix="$nixpkgs/pkgs/development/tools/build-managers/sbt-extras/default.nix"
       latestDate="$(curl -L -s https://api.github.com/repos/paulp/sbt-extras/commits/$latestSha | jq '.commit.committer.date' | sed 's|"\(.*\)T.*|\1|g')"
       update-source-version ${pname} "$latestSha" --version-key=rev
       update-source-version ${pname} "$latestDate" --ignore-same-hash
       nixfmt "$default_nix"
     else
       echo "${pname} is already up-to-date"
     fi
  '';

  meta = {
    description =
      "A more featureful runner for sbt, the simple/scala/standard build tool";
    homepage = "https://github.com/paulp/sbt-extras";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ nequissimus puffnfresh ];
    platforms = lib.platforms.unix;
  };
}

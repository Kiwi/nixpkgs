{ lib
, buildPythonPackage
, fetchPypi
, buildbot
, setuptoolsTrial
, mock
, twisted
, future
, coreutils
}:

buildPythonPackage (rec {
  pname = "buildbot-worker";
  inherit (buildbot) version;

  src = fetchPypi {
    inherit pname version;
    sha256 = "10ap7jlxs9vcmnyafr62mxlgsp709165nw55xmv9sw18r7m8wsm6";
  };

  propagatedBuildInputs = [ twisted future ];

  checkInputs = [ setuptoolsTrial mock ];

  postPatch = ''
    substituteInPlace buildbot_worker/scripts/logwatcher.py \
      --replace /usr/bin/tail "${coreutils}/bin/tail"
  '';

  meta = with lib; {
    homepage = "https://buildbot.net/";
    description = "Buildbot Worker Daemon";
    maintainers = with maintainers; [ nand0p ryansydnor lopsided98 ];
    license = licenses.gpl2;
  };
})

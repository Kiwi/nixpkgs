{ lib
, stdenv
, buildPythonPackage
, fetchPypi
, isPy27
, backports_ssl_match_hostname
, mock
, paramiko
, pytest
, pytestCheckHook
, requests
, six
, websocket_client
}:

buildPythonPackage rec {
  pname = "docker";
  version = "4.4.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-BgSnRxnV0t5Dh1OTS3Vb/NpvYvSbjkswlppLCiqKEiA=";
  };

  nativeBuildInputs = lib.optional isPy27 mock;

  propagatedBuildInputs = [
    paramiko
    requests
    six
    websocket_client
  ] ++ lib.optional isPy27 backports_ssl_match_hostname;

  checkInputs = [
    pytestCheckHook
  ];

  pytestFlagsArray = [ "tests/unit" ];
  # Deselect socket tests on Darwin because it hits the path length limit for a Unix domain socket
  disabledTests = lib.optionals stdenv.isDarwin [ "stream_response" "socket_file" ];

  dontUseSetuptoolsCheck = true;

  meta = with lib; {
    description = "An API client for docker written in Python";
    homepage = "https://github.com/docker/docker-py";
    license = licenses.asl20;
    maintainers = with maintainers; [ jonringer ];
  };
}

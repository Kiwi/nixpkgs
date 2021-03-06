{ lib
, buildDunePackage
, fetchurl
, fmt
, mirage-flow
, result
, rresult
, cstruct
, logs
, ke
, alcotest
, alcotest-lwt
, bigstringaf
, bigarray-compat
}:

buildDunePackage rec {
  pname = "mimic";
  version = "0.0.1";

  minimumOCamlVersion = "4.08";
  useDune2 = true;

  src = fetchurl {
    url = "https://github.com/mirage/ocaml-git/releases/download/${pname}-v${version}/${pname}-${pname}-v${version}.tbz";
    sha256 = "0j4l99sgm5mdmv67vakkz2pw45l6i89bpza88xqkgmskfk50c5pk";
  };

  # don't install changelogs for other packages
  postPatch = ''
    rm -f CHANGES.md CHANGES.carton.md
  '';

  propagatedBuildInputs = [
    fmt
    mirage-flow
    result
    rresult
    cstruct
    logs
  ];

  doCheck = true;
  checkInputs = [
    alcotest
    alcotest-lwt
    bigstringaf
    bigarray-compat
    ke
  ];

  meta = with lib; {
    description = "A simple protocol dispatcher";
    license = licenses.isc;
    homepage = "https://github.com/mirage/ocaml-git";
    maintainers = [ maintainers.sternenseemann ];
  };
}

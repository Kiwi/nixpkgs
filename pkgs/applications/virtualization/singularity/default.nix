{ stdenv
, lib
, fetchurl
, util-linux
, gpgme
, openssl
, libuuid
, coreutils
, go
, which
, makeWrapper
, cryptsetup
, squashfsTools
, buildGoPackage
}:

with lib;

buildGoPackage rec {
  pname = "singularity";
  version = "3.7.0";

  src = fetchurl {
    url = "https://github.com/hpcng/singularity/releases/download/v${version}/singularity-${version}.tar.gz";
    sha256 = "0y6lm23g6a2ljm78w8iyak7yivxvpj3i55fjbd56m9b2ykssm5pv";
  };

  goPackagePath = "github.com/sylabs/singularity";

  buildInputs = [ gpgme openssl libuuid ];
  nativeBuildInputs = [ util-linux which makeWrapper cryptsetup ];
  propagatedBuildInputs = [ coreutils squashfsTools ];

  postPatch = ''
    substituteInPlace internal/pkg/build/files/copy.go \
      --replace /bin/cp ${coreutils}/bin/cp
  '';

  postConfigure = ''
    cd go/src/github.com/sylabs/singularity

    patchShebangs .
    sed -i 's|defaultPath := "[^"]*"|defaultPath := "${stdenv.lib.makeBinPath propagatedBuildInputs}"|' cmd/internal/cli/actions.go

    ./mconfig -V ${version} -p $out --localstatedir=/var

    # Don't install SUID binaries
    sed -i 's/-m 4755/-m 755/g' builddir/Makefile
  '';

  buildPhase = ''
    runHook preBuild
    make -C builddir
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    make -C builddir install LOCALSTATEDIR=$out/var
    chmod 755 $out/libexec/singularity/bin/starter-suid

    # Explicitly configure paths in the config file
    sed -i 's|^# mksquashfs path =.*$|mksquashfs path = ${stdenv.lib.makeBinPath [ squashfsTools ]}/mksquashfs|' $out/etc/singularity/singularity.conf
    sed -i 's|^# cryptsetup path =.*$|cryptsetup path = ${stdenv.lib.makeBinPath [ cryptsetup ]}/cryptsetup|' $out/etc/singularity/singularity.conf

    runHook postInstall
  '';

  meta = with stdenv.lib; {
    homepage = "http://www.sylabs.io/";
    description = "Application containers for linux";
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = [ maintainers.jbedo ];
  };
}

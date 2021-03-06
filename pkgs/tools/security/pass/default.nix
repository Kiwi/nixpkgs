{ stdenv
, lib
, pkgs
, fetchurl
, buildEnv
, coreutils
, findutils
, gnugrep
, gnused
, getopt
, git
, tree
, gnupg
, openssl
, which
, procps
, qrencode
, makeWrapper
, pass
, symlinkJoin

, xclip ? null
, xdotool ? null
, dmenu ? null
, x11Support ? !stdenv.isDarwin
, dmenuSupport ? x11Support
, waylandSupport ? false
, wl-clipboard ? null

  # For backwards-compatibility
, tombPluginSupport ? false
}:

with lib;

assert x11Support -> xclip != null;

assert dmenuSupport -> dmenu != null
  && xdotool != null
  && x11Support;

assert waylandSupport -> wl-clipboard != null;

let
  passExtensions = import ./extensions { inherit pkgs; };

  env = extensions:
    let
      selected = [ pass ] ++ extensions passExtensions
        ++ lib.optional tombPluginSupport passExtensions.tomb;
    in
    buildEnv {
      name = "pass-extensions-env";
      paths = selected;
      buildInputs = [ makeWrapper ] ++ concatMap (x: x.buildInputs) selected;

      postBuild = ''
        files=$(find $out/bin/ -type f -exec readlink -f {} \;)
        if [ -L $out/bin ]; then
          rm $out/bin
          mkdir $out/bin
        fi

        for i in $files; do
          if ! [ "$(readlink -f "$out/bin/$(basename $i)")" = "$i" ]; then
            ln -sf $i $out/bin/$(basename $i)
          fi
        done

        wrapProgram $out/bin/pass \
          --set SYSTEM_EXTENSION_DIR "$out/lib/password-store/extensions"
      '';
    };
in

stdenv.mkDerivation rec {
  version = "1.7.3";
  pname = "password-store";

  src = fetchurl {
    url = "https://git.zx2c4.com/password-store/snapshot/${pname}-${version}.tar.xz";
    sha256 = "1x53k5dn3cdmvy8m4fqdld4hji5n676ksl0ql4armkmsds26av1b";
  };

  patches = [
    ./set-correct-program-name-for-sleep.patch
    ./extension-dir.patch
  ] ++ lib.optional stdenv.isDarwin ./no-darwin-getopt.patch
  # TODO (@Ma27) this patch adds support for wl-clipboard and can be removed during the next
  # version bump.
  ++ lib.optional waylandSupport ./clip-wayland-support.patch;

  nativeBuildInputs = [ makeWrapper ];

  installFlags = [ "PREFIX=$(out)" "WITH_ALLCOMP=yes" ];

  postInstall = ''
    # Install Emacs Mode. NOTE: We can't install the necessary
    # dependencies (s.el and f.el) here. The user has to do this
    # himself.
    mkdir -p "$out/share/emacs/site-lisp"
    cp "contrib/emacs/password-store.el" "$out/share/emacs/site-lisp/"
  '' + optionalString dmenuSupport ''
    cp "contrib/dmenu/passmenu" "$out/bin/"
  '';

  wrapperPath = with lib; makeBinPath ([
    coreutils
    findutils
    getopt
    git
    gnugrep
    gnupg
    gnused
    tree
    which
    qrencode
    procps
  ] ++ optional stdenv.isDarwin openssl
  ++ optional x11Support xclip
  ++ optionals dmenuSupport [ xdotool dmenu ]
  ++ optional waylandSupport wl-clipboard);

  postFixup = ''
    # Fix program name in --help
    substituteInPlace $out/bin/pass \
      --replace 'PROGRAM="''${0##*/}"' "PROGRAM=pass"

    # Ensure all dependencies are in PATH
    wrapProgram $out/bin/pass \
      --prefix PATH : "${wrapperPath}"
  '' + lib.optionalString dmenuSupport ''
    # We just wrap passmenu with the same PATH as pass. It doesn't
    # need all the tools in there but it doesn't hurt either.
    wrapProgram $out/bin/passmenu \
      --prefix PATH : "$out/bin:${wrapperPath}"
  '';

  # Turn "check" into "installcheck", since we want to test our pass,
  # not the one before the fixup.
  postPatch = ''
    patchShebangs tests

    substituteInPlace src/password-store.sh \
      --replace "@out@" "$out"

    # the turning
    sed -i -e 's@^PASS=.*''$@PASS=$out/bin/pass@' \
           -e 's@^GPGS=.*''$@GPG=${gnupg}/bin/gpg2@' \
           -e '/which gpg/ d' \
      tests/setup.sh
  '' + lib.optionalString stdenv.isDarwin ''
    # 'pass edit' uses hdid, which is not available from the sandbox.
    rm -f tests/t0200-edit-tests.sh
    rm -f tests/t0010-generate-tests.sh
    rm -f tests/t0020-show-tests.sh
    rm -f tests/t0050-mv-tests.sh
    rm -f tests/t0100-insert-tests.sh
    rm -f tests/t0300-reencryption.sh
    rm -f tests/t0400-grep.sh
  '';

  doCheck = false;

  doInstallCheck = true;
  installCheckInputs = [ git ];
  installCheckTarget = "test";

  passthru = {
    extensions = passExtensions;
    withExtensions = env;
  };

  meta = with lib; {
    description = "Stores, retrieves, generates, and synchronizes passwords securely";
    homepage = "https://www.passwordstore.org/";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ lovek323 fpletz tadfisher globin ma27 ];
    platforms = platforms.unix;

    longDescription = ''
      pass is a very simple password store that keeps passwords inside gpg2
      encrypted files inside a simple directory tree residing at
      ~/.password-store. The pass utility provides a series of commands for
      manipulating the password store, allowing the user to add, remove, edit,
      synchronize, generate, and manipulate passwords.
    '';
  };
}

{ pkgs
, poetry2nix
, lib
, overrides ? (self: super: { })
}:

let

  interpreter = (
    poetry2nix.mkPoetryPackages {
      projectDir = ./.;
      overrides = [
        poetry2nix.defaultPoetryOverrides
        (import ./poetry-git-overlay.nix { inherit pkgs; })
        (
          self: super: {

            nixops = super.nixops.overridePythonAttrs (
              old: {
                meta = old.meta // {
                  homepage = https://github.com/NixOS/nixops;
                  description = "NixOS cloud provisioning and deployment tool";
                  maintainers = with lib.maintainers; [ adisbladis aminechikhaoui eelco rob domenkozar ];
                  platforms = lib.platforms.unix;
                  license = lib.licenses.lgpl3;
                };

              }
            );
          }
        )

        # User provided overrides
        overrides

        # Make nixops pluginable
        (self: super: {
          nixops = super.__toPluginAble {
            drv = super.nixops;
            finalDrv = self.nixops;

            nativeBuildInputs = [ self.sphinx ];
            postInstall = ''
              doc_cache=$(mktemp -d)
              sphinx-build -b man -d $doc_cache doc/ $out/share/man/man1

              html=$(mktemp -d)
              sphinx-build -b html -d $doc_cache doc/ $out/share/nixops/doc
            '';

          };
        })

      ];
    }
  ).python;

in
interpreter.pkgs.nixops.withPlugins (ps: [
  ps.nixops-encrypted-links
  ps.nixops-virtd
  ps.nixops-aws
  ps.nixops-gcp
  ps.nixopsvbox
])

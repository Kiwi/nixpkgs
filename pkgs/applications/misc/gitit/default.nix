{ lib
, haskellPackages
, haskell
, removeReferencesTo
  # “Plugins” are a fancy way of saying gitit will invoke
  # GHC at *runtime*, which in turn makes it pull GHC
  # into its runtime closure. Only enable if you really need
  # that feature. But if you do you’ll want to use gitit
  # as a library anyway.
, pluginSupport ? false
}:

# this is similar to what we do with the pandoc executable

let
  plain = haskellPackages.gitit;
  plugins =
    if pluginSupport
    then plain
    else haskell.lib.disableCabalFlag plain "plugins";
  static = haskell.lib.justStaticExecutables plugins;

in
(haskell.lib.overrideCabal static (drv: {
  buildTools = (drv.buildTools or [ ]) ++ [ removeReferencesTo ];
})).overrideAttrs (drv: {

  # These libraries are still referenced, because they generate
  # a `Paths_*` module for figuring out their version.
  # The `Paths_*` module is generated by Cabal, and contains the
  # version, but also paths to e.g. the data directories, which
  # lead to a transitive runtime dependency on the whole GHC distribution.
  # This should ideally be fixed in haskellPackages (or even Cabal),
  # but a minimal gitit is important enough to patch it manually.
  disallowedReferences = [
    haskellPackages.pandoc-types
    haskellPackages.HTTP
    haskellPackages.pandoc
    haskellPackages.happstack-server
    haskellPackages.filestore
  ];
  postInstall = ''
    remove-references-to \
      -t ${haskellPackages.pandoc-types} \
      $out/bin/gitit
    remove-references-to \
      -t ${haskellPackages.HTTP} \
      $out/bin/gitit
    remove-references-to \
      -t ${haskellPackages.pandoc} \
      $out/bin/gitit
    remove-references-to \
      -t ${haskellPackages.happstack-server} \
      $out/bin/gitit
    remove-references-to \
      -t ${haskellPackages.filestore} \
      $out/bin/gitit
  '';

  meta = drv.meta // {
    maintainers = drv.meta.maintainers or [ ]
      ++ [ lib.maintainers.Profpatsch ];
  };
})

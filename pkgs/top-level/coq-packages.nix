{ lib
, callPackage
, newScope
, recurseIntoAttrs
, ocamlPackages_4_05
, ocamlPackages_4_09
, compcert
}:

let
  mkCoqPackages' = self: coq:
    let callPackage = self.callPackage; in
    {
      inherit coq;
      coqPackages = self;

      contribs = recurseIntoAttrs
        (callPackage ../development/coq-modules/contribs { });

      autosubst = callPackage ../development/coq-modules/autosubst { };
      bignums =
        if lib.versionAtLeast coq.coq-version "8.6"
        then callPackage ../development/coq-modules/bignums { }
        else null;
      category-theory = callPackage ../development/coq-modules/category-theory { };
      Cheerios = callPackage ../development/coq-modules/Cheerios { };
      CoLoR = callPackage ../development/coq-modules/CoLoR { };
      coq-bits = callPackage ../development/coq-modules/coq-bits { };
      coq-elpi = callPackage ../development/coq-modules/coq-elpi { };
      coq-ext-lib = callPackage ../development/coq-modules/coq-ext-lib { };
      coq-haskell = callPackage ../development/coq-modules/coq-haskell { };
      coqhammer = callPackage ../development/coq-modules/coqhammer { };
      coqprime = callPackage ../development/coq-modules/coqprime { };
      coquelicot = callPackage ../development/coq-modules/coquelicot { };
      corn = callPackage ../development/coq-modules/corn { };
      dpdgraph = callPackage ../development/coq-modules/dpdgraph { };
      equations = callPackage ../development/coq-modules/equations { };
      fiat_HEAD = callPackage ../development/coq-modules/fiat/HEAD.nix { };
      flocq = callPackage ../development/coq-modules/flocq { };
      gappalib = callPackage ../development/coq-modules/gappalib { };
      heq = callPackage ../development/coq-modules/heq { };
      hierarchy-builder = callPackage ../development/coq-modules/hierarchy-builder { };
      HoTT = callPackage ../development/coq-modules/HoTT { };
      interval = callPackage ../development/coq-modules/interval { };
      InfSeqExt = callPackage ../development/coq-modules/InfSeqExt { };
      iris = callPackage ../development/coq-modules/iris { };
      ltac2 = callPackage ../development/coq-modules/ltac2 { };
      math-classes = callPackage ../development/coq-modules/math-classes { };
      inherit (callPackage ../development/coq-modules/mathcomp { })
        mathcomp_ mathcomp-config
        mathcomp ssreflect
        mathcomp-ssreflect mathcomp-fingroup mathcomp-algebra
        mathcomp-solvable mathcomp-field mathcomp-character
        ;
      inherit (callPackage ../development/coq-modules/mathcomp/extra.nix { })
        mathcomp-extra-override mathcomp-extra-config mathcomp-extra
        current-mathcomp-extra mathcomp-extra-fast mathcomp-extra-all
        mathcomp-finmap mathcomp-bigenough mathcomp-real-closed
        mathcomp-analysis multinomials coqeal
        ;
      metalib = callPackage ../development/coq-modules/metalib { };
      paco = callPackage ../development/coq-modules/paco { };
      paramcoq = callPackage ../development/coq-modules/paramcoq { };
      QuickChick = callPackage ../development/coq-modules/QuickChick { };
      simple-io = callPackage ../development/coq-modules/simple-io { };
      stdpp = callPackage ../development/coq-modules/stdpp { };
      StructTact = callPackage ../development/coq-modules/StructTact { };
      tlc = callPackage ../development/coq-modules/tlc { };
      Velisarios = callPackage ../development/coq-modules/Velisarios { };
      Verdi = callPackage ../development/coq-modules/Verdi { };
      VST = callPackage ../development/coq-modules/VST {
        compcert = compcert.override { version = "3.7"; };
      };

      filterPackages = filterCoqPackages;
    };

  filterCoqPackages = coq: set:
    lib.listToAttrs (
      lib.concatMap
        (name:
          let v = set.${name}; in
          let p = v.compatibleCoqVersions or (_: true); in
          lib.optional (p coq.coq-version)
            (lib.nameValuePair name (
              if lib.isAttrs v && v.recurseForDerivations or false
              then filterCoqPackages coq v
              else v
            ))
        )
        (lib.attrNames set)
    );

in
rec {

  /* The function `mkCoqPackages` takes as input a derivation for Coq and produces
   * a set of libraries built with that specific Coq. More libraries are known to
   * this function than what is compatible with that version of Coq. Therefore,
   * libraries that are not known to be compatible are removed (filtered out) from
   * the resulting set. For meta-programming purposes (inpecting the derivations
   * rather than building the libraries) this filtering can be disabled by setting
   * a `dontFilter` attribute into the Coq derivation.
   */
  mkCoqPackages = coq:
    let self = lib.makeScope newScope (lib.flip mkCoqPackages' coq); in
    if coq.dontFilter or false then self else filterCoqPackages coq self;

  coq_8_5 = callPackage ../applications/science/logic/coq {
    ocamlPackages = ocamlPackages_4_05;
    version = "8.5pl3";
  };
  coq_8_6 = callPackage ../applications/science/logic/coq {
    ocamlPackages = ocamlPackages_4_05;
    version = "8.6.1";
  };
  coq_8_7 = callPackage ../applications/science/logic/coq {
    ocamlPackages = ocamlPackages_4_09;
    version = "8.7.2";
  };
  coq_8_8 = callPackage ../applications/science/logic/coq {
    ocamlPackages = ocamlPackages_4_09;
    version = "8.8.2";
  };
  coq_8_9 = callPackage ../applications/science/logic/coq {
    ocamlPackages = ocamlPackages_4_09;
    version = "8.9.1";
  };
  coq_8_10 = callPackage ../applications/science/logic/coq {
    ocamlPackages = ocamlPackages_4_09;
    version = "8.10.2";
  };
  coq_8_11 = callPackage ../applications/science/logic/coq {
    version = "8.11.2";
  };
  coq_8_12 = callPackage ../applications/science/logic/coq {
    version = "8.12.2";
  };
  coq_8_13 = callPackage ../applications/science/logic/coq {
    version = "8.13+beta1";
  };

  coqPackages_8_5 = mkCoqPackages coq_8_5;
  coqPackages_8_6 = mkCoqPackages coq_8_6;
  coqPackages_8_7 = mkCoqPackages coq_8_7;
  coqPackages_8_8 = mkCoqPackages coq_8_8;
  coqPackages_8_9 = mkCoqPackages coq_8_9;
  coqPackages_8_10 = mkCoqPackages coq_8_10;
  coqPackages_8_11 = mkCoqPackages coq_8_11;
  coqPackages_8_12 = mkCoqPackages coq_8_12;
  coqPackages_8_13 = mkCoqPackages coq_8_13;
  coqPackages = recurseIntoAttrs (lib.mapDerivationAttrset lib.dontDistribute
    coqPackages_8_11
  );
  coq = coqPackages.coq;

}

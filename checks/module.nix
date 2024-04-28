{inputs, ...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  } @ args: let
    inherit (lib) callPackageWith;

    mkTest = test:
      pkgs.stdenv.mkDerivation ({
          dontPatch = true;
          dontConfigure = true;
          dontBuild = true;
          dontInstall = true;
          doCheck = true;
        }
        // test);
    callPackage = callPackageWith (pkgs
      // {
        inherit mkTest;
        self = builtins.path {
          name = "dotfiles";
          path = inputs.self;
        };
      });
  in {
    checks.fmt = callPackage ./fmt.nix {};
  };
}

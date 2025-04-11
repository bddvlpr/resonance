{
  perSystem = {
    pkgs,
    lib,
    inputs',
    ...
  }: let
    mkApp = program: {
      type = "app";
      inherit program;
    };
  in {
    apps = {
      bootstrap = mkApp (import ./bootstrap.nix {inherit pkgs lib inputs';});
      genkeys = mkApp (import ./genkeys.nix {inherit pkgs lib;});
    };
  };
}

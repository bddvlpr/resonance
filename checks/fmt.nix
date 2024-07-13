{
  mkTest,
  lib,
  self,
  alejandra,
  ...
}: let
  src = lib.sourceFilesBySuffices self [".nix"];
in
  mkTest {
    name = "fmt";

    inherit src;

    checkInputs = [alejandra];
    checkPhase = ''
      mkdir -p $out
      alejandra --check . | tee $out/test.log
    '';
  }

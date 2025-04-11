{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) getExe;
in {
  telemetry.metrics = false;
  inlay_hints.enabled = true;

  diagnostics = {
    inline.enabled = true;
  };

  languages = {
    Nix = {
      formatter.external = {
        command = getExe pkgs.alejandra;
        args = ["--quiet" "--"];
      };
    };
  };
}

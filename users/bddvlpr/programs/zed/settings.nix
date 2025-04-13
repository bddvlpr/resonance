{
  lib,
  pkgs,
  osConfig,
  config,
  ...
}: let
  inherit (lib) getExe;

  inherit (osConfig.bowl.users.${config.home.username}) shell;
in {
  telemetry.metrics = false;
  inlay_hints.enabled = true;

  diagnostics = {
    inline.enabled = true;
  };

  terminal.shell.program = getExe shell;

  languages = {
    Nix = {
      formatter.external = {
        command = getExe pkgs.alejandra;
        args = ["--quiet" "--"];
      };
    };
  };
}

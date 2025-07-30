{
  lib,
  pkgs,
  osConfig,
  config,
  ...
}:
let
  inherit (lib) getExe mkForce;

  inherit (osConfig.bowl.users.${config.home.username}) shell;
in
{
  theme = mkForce "Rosé Pine Moon";

  telemetry.metrics = false;
  inlay_hints.enabled = true;

  diagnostics = {
    inline.enabled = true;
  };

  terminal.shell.program = getExe shell;

  file_scan_exclusions = [
    "**/node_modules"
  ];

  languages = {
    Nix = {
      formatter.external = {
        command = getExe pkgs.alejandra;
        args = [
          "--quiet"
          "--"
        ];
      };
    };
  };
}

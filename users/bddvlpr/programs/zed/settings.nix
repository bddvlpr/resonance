{
  lib,
  pkgs,
  osConfig,
  config,
  ...
}:
let
  inherit (osConfig.bowl.users.${config.home.username}) shell;
in
{
  theme = lib.mkForce "Rosé Pine Moon";

  telemetry.metrics = false;
  inlay_hints.enabled = true;

  diagnostics = {
    inline.enabled = true;
  };

  terminal.shell.program = lib.getExe shell;

  file_scan_exclusions = [
    "**/node_modules"
  ];

  languages = {
    Nix = {
      formatter.external = {
        command = lib.getExe pkgs.nixfmt-rfc-style;
        args = [
          "--quiet"
          "--"
        ];
      };
    };
  };
}

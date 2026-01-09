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
  inlay_hints = {
    enabled = true;
    show_type_hints = false;
  };

  diagnostics = {
    inline.enabled = true;
  };

  terminal.shell.program = lib.getExe shell;

  file_scan_exclusions = [
    "**/node_modules"
  ];

  languages =
    let
      biomeConfiguration = {
        formatter.language_server.name = "biome";
        code_actions_on_format = {
          "source.fixAll.biome" = true;
          "source.organizeImports.biome" = true;
        };
      };
    in
    {
      Nix = {
        formatter.external = {
          command = lib.getExe pkgs.nixfmt;
          args = [
            "--quiet"
            "--"
          ];
        };
      };

      JavaScript = biomeConfiguration;
      TypeScript = biomeConfiguration;
      TSX = biomeConfiguration;
      JSON = biomeConfiguration;
      JSONC = biomeConfiguration;
      CSS = biomeConfiguration;
      GraphQL = biomeConfiguration;
    };
}

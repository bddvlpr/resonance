{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkIf
    mkMerge
    mkOption
    strings
    types
    ;

  cfg = config.bowl.persist;
in
{
  imports = [ inputs.impermanence.homeManagerModules.default ];

  options.bowl.persist = {
    enable = mkOption {
      type = types.bool;
      default = pkgs.stdenv.buildPlatform.isLinux; # TODO: Add metadata about a system to determine if it is impermanent or not.
      description = "Whether to enable persistance service mounts for tmpfs systems.";
    };

    allowOther = mkOption {
      type = types.bool;
      default = true;
      description = "Allow other users to access the mounts.";
    };

    entries = mkOption {
      type =
        with types;
        listOf (submodule {
          options = {
            path = mkOption {
              type = str;
              description = "The path to create a mount for.";
            };
            type = mkOption {
              type = enum [
                "file"
                "directory"
              ];
              default = "directory";
              description = "Is the path a file or a directory.";
            };
          };
        });
      default = [ ];
      description = "The entries to create mounts for.";
    };
  };

  config = mkIf cfg.enable {
    home.persistence = mkMerge (
      map (
        {
          path,
          type,
        }:
        {
          "${strings.normalizePath "/persist/${config.home.homeDirectory}"}" =
            (if type == "directory" then { directories = [ path ]; } else { files = [ path ]; })
            // {
              inherit (cfg) allowOther;
            };
        }
      ) cfg.entries
    );
  };
}

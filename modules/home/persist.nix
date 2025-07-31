{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
let
  cfg = config.bowl.persist;
in
{
  imports = [ inputs.impermanence.homeManagerModules.default ];

  options.bowl.persist = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = pkgs.stdenv.buildPlatform.isLinux; # TODO: Add metadata about a system to determine if it is impermanent or not.
      description = "Whether to enable persistance service mounts for tmpfs systems.";
    };

    allowOther = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Allow other users to access the mounts.";
    };

    entries = lib.mkOption {
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            path = lib.mkOption {
              type = lib.types.str;
              description = "The path to create a mount for.";
            };
            type = lib.mkOption {
              type = lib.types.enum [
                "file"
                "directory"
              ];
              default = "directory";
              description = "Is the path a file or a directory.";
            };
          };
        }
      );
      default = [ ];
      description = "The entries to create mounts for.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.persistence = lib.mkMerge (
      map (
        {
          path,
          type,
        }:
        {
          "${lib.strings.normalizePath "/persist/${config.home.homeDirectory}"}" =
            (if type == "directory" then { directories = [ path ]; } else { files = [ path ]; })
            // {
              inherit (cfg) allowOther;
            };
        }
      ) cfg.entries
    );
  };
}

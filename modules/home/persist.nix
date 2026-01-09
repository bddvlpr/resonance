{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.bowl.persist;
in
{
  options.bowl.persist = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = pkgs.stdenv.buildPlatform.isLinux; # TODO: Add metadata about a system to determine if it is impermanent or not.
      description = "Whether to enable persistance service mounts for tmpfs systems.";
    };

    entries = lib.mkOption {
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            from = lib.mkOption {
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
          from,
          type,
        }:
        {
          "/persist" = (
            if type == "directory" then
              {
                directories = [
                  {
                    directory = from;
                  }
                ];
              }
            else
              {
                files = [ from ];
              }
          );
        }
      ) cfg.entries
    );
  };
}

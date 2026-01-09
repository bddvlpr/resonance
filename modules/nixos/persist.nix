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
  imports = [ inputs.impermanence.nixosModules.default ];

  options.bowl.persist = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = pkgs.stdenv.buildPlatform.isLinux; # TODO: Add metadata about a system to determine if it is impermanent or not.
      description = "Whether to enable persistence service mounts for tmpfs systems.";
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
            mode = lib.mkOption {
              type = lib.types.str;
              default = "0755";
              description = "Initial mode upon creation of this path.";
            };
            user = lib.mkOption {
              type = lib.types.str;
              default = "root";
              description = "Initial owner upon creation of this path.";
            };
            group = lib.mkOption {
              type = lib.types.str;
              default = "root";
              description = "Initial group upon creation of this path.";
            };
          };
        }
      );
      default = [ ];
      description = "The entries to create mounts for.";
    };
  };

  config = lib.mkIf cfg.enable {
    bowl.persist.entries = [
      { from = "/var/lib/nixos"; }
      { from = "/var/lib/systemd/coredump"; }
      { from = "/var/log"; }
    ];

    environment.persistence = lib.mkMerge (
      map (
        {
          from,
          type,
          mode,
          user,
          group,
        }:
        let
          commonArgs = { inherit mode user group; };
        in
        {
          "/persist" =
            if type == "directory" then
              { directories = [ ({ directory = from; } // commonArgs) ]; }
            else
              { files = [ ({ file = from; } // commonArgs) ]; };
        }
      ) cfg.entries
    );
  };
}

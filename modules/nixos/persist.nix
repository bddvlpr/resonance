{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
let
  inherit (lib)
    listToAttrs
    mkIf
    mkOption
    nameValuePair
    types
    ;

  cfg = config.bowl.persist;
in
{
  imports = [ inputs.impermanence.nixosModules.default ];

  options.bowl.persist = {
    enable = mkOption {
      type = types.bool;
      default = pkgs.stdenv.buildPlatform.isLinux; # TODO: Add metadata about a system to determine if it is impermanent or not.
      description = "Whether to enable persistence service mounts for tmpfs systems.";
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
            mode = mkOption {
              type = str;
              default = "0755";
              description = "Initial mode upon creation of this path.";
            };
            user = mkOption {
              type = str;
              default = "root";
              description = "Initial owner upon creation of this path.";
            };
            group = mkOption {
              type = str;
              default = "root";
              description = "Initial group upon creation of this path.";
            };
          };
        });
      default = [ ];
      description = "The entries to create mounts for.";
    };
  };

  config = mkIf cfg.enable {
    bowl.persist.entries = [
      { path = "/var/lib/nixos"; }
      { path = "/var/lib/systemd/coredump"; }
      { path = "/var/log"; }
    ];

    environment.persistence = listToAttrs (
      map (
        {
          path,
          type,
          mode,
          user,
          group,
        }:
        nameValuePair path (
          let
            commonArgs = { inherit mode user group; };
          in
          (
            if type == "directory" then
              { directories = [ ({ directory = path; } // commonArgs) ]; }
            else
              { files = [ ({ file = path; } // commonArgs) ]; }
          )
          // {
            persistentStoragePath = "/persist";
          }
        )
      ) cfg.entries
    );

    programs.fuse.userAllowOther = true;
  };
}

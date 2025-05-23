{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  inherit (lib) attrNames mkIf mkMerge mkOption strings types;

  cfg = config.bowl.persist;
in {
  imports = [inputs.impermanence.nixosModules.default];

  options.bowl.persist = {
    enable = mkOption {
      type = types.bool;
      default = pkgs.stdenv.buildPlatform.isLinux; # TODO: Add metadata about a system to determine if it is impermanent or not.
      description = "Whether to enable persistence service mounts for tmpfs systems.";
    };

    entries = mkOption {
      type = with types;
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
      default = [];
      description = "The entries to create mounts for.";
    };
  };

  config = mkIf cfg.enable {
    bowl.persist.entries = [
      {path = "/var/lib/nixos";}
      {path = "/var/lib/systemd/coredump";}
      {path = "/var/log";}
    ];

    environment.persistence = mkMerge (map (
        {
          path,
          type,
          mode,
          user,
          group,
        }: let
          commonArgs = {inherit mode user group;};
        in {
          "/persist" =
            if type == "directory"
            then {directories = [({directory = path;} // commonArgs)];}
            else {files = [({file = path;} // commonArgs)];};
        }
      )
      cfg.entries);

    systemd.tmpfiles.rules = map (name: let
      user = config.users.users.${name};
      path = strings.normalizePath "/persist/${user.home}";
    in "d ${path} 700 ${user.name} ${user.group}")
    (attrNames config.bowl.users);

    programs.fuse.userAllowOther = true;
  };
}

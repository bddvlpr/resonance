{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types;
in {
  imports = [
    ./hyprland.nix
    ./sway.nix
  ];

  options.bowl.desktop = {
    enable = mkOption {
      type = types.bool;
      default = pkgs.stdenv.hostPlatform.isLinux;
      description = "Whether to enable the desktop environments or not.";
    };

    environments = mkOption {
      type = with types; listOf (enum ["hyprland" "sway"]);
      default = ["hyprland" "sway"];
      description = "Which desktop environments to use for this user.";
    };

    monitors = mkOption {
      type = with types;
        listOf (submodule {
          options = {
            name = mkOption {
              type = str;
              example = "DP-1";
            };
            enable = mkOption {
              type = bool;
              default = true;
            };
            workspace = mkOption {
              type = nullOr int;
              default = null;
              example = 1;
            };

            width = mkOption {
              type = int;
              default = 1920;
            };
            height = mkOption {
              type = int;
              default = 1090;
            };
            refreshRate = mkOption {
              type = int;
              default = 60;
            };

            x = mkOption {
              type = int;
              default = 0;
            };
            y = mkOption {
              type = int;
              default = 0;
            };

            scale = mkOption {
              type = float;
              default = 1.0;
            };
          };
        });
      default = [];
      description = "Monitors to bootstrap in window managers.";
    };
  };
}

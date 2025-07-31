{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hyprland
    ./sway
  ];

  options.bowl.desktop = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = pkgs.stdenv.hostPlatform.isLinux;
      description = "Whether to enable the desktop environments or not.";
    };

    environments = lib.mkOption {
      type =
        with lib.types;
        listOf (enum [
          "hyprland"
          "sway"
        ]);
      default = [ "hyprland" ];
      description = "Which desktop environments to use for this user.";
    };

    monitors = lib.mkOption {
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            name = lib.mkOption {
              type = lib.types.str;
              example = "DP-1";
            };
            enable = lib.mkOption {
              type = lib.types.bool;
              default = true;
            };
            workspace = lib.mkOption {
              type = with lib.types; nullOr int;
              default = null;
              example = 1;
            };
            bar = lib.mkOption {
              type = lib.types.enum [
                "big"
                "tiny"
              ];
              default = "big";
              example = "tiny";
            };

            width = lib.mkOption {
              type = lib.types.int;
              default = 1920;
            };
            height = lib.mkOption {
              type = lib.types.int;
              default = 1090;
            };
            refreshRate = lib.mkOption {
              type = lib.types.int;
              default = 60;
            };

            x = lib.mkOption {
              type = lib.types.int;
              default = 0;
            };
            y = lib.mkOption {
              type = lib.types.int;
              default = 0;
            };

            scale = lib.mkOption {
              type = lib.types.float;
              default = 1.0;
            };
          };
        }
      );
      default = [ ];
      description = "Monitors to bootstrap in window managers.";
    };
  };
}

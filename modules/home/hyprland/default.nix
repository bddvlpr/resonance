{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.hyprland;
in {
  options.sysc.hyprland = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable Hyprland.";
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      xwayland.enable = true;

      settings = {
        "$mod" = "SUPER";

        exec = [
          "${lib.getExe pkgs.swaybg} -i ${config.stylix.image} --mode fill"
        ];

        general = {
          gaps_in = 4;
          gaps_out = 8;
          border_size = 2;
        };

        dwindle = {
          preserve_split = true;
        };

        bind = let
          inherit (lib) getExe;
        in
          [
            "$mod, Q, killactive,"
            "$mod SHIFT, Q, exit,"

            "$mod, Return, exec, ${getExe pkgs.kitty}"
            "$mod, SPACE, exec, ${getExe pkgs.wofi} -S drun"

            "$mod SHIFT, SPACE, togglefloating,"
            "$mod, S, togglesplit"
            "$mod, F, fullscreen,"
            "$mod, P, pseudo,"

            "$mod, G, togglegroup"
            "$mod, Tab, changegroupactive"
          ]
          ++ (
            builtins.concatLists (
              builtins.genList (x: let
                ws = builtins.toString (x + 1);
              in [
                "$mod, ${ws}, workspace, ${ws}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${ws}"
              ])
              9
            )
          );

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        monitor = [
          ",highres,auto,1"
        ];

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };
      };
    };

    home.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}

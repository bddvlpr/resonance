{
  lib,
  config,
  pkgs,
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
      };
    };

    home.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}

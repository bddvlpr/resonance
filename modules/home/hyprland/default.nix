{
  lib,
  config,
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

      settings = {
        "$mod" = "SUPER";

        bind =
          []
          ++ (
            builtins.concatLists (
              builtins.genList (x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c + 1));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ])
              10
            )
          );
      };
    };
  };
}

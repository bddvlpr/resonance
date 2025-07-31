{
  lib,
  pkgs,
  config,
  ...
}:
let
  workspaces = lib.genList (w: toString (w + 1)) 9;
in
{
  imports = [
    ./swaylock.nix
  ];

  wayland.windowManager.sway = {
    config = rec {
      defaultWorkspace = "1";

      terminal = lib.getExe pkgs.kitty;

      gaps = {
        outer = 5;
        inner = 12;
      };

      bars = [
        (
          {
            mode = "dock";
            position = "top";
          }
          // config.lib.stylix.sway.bar
        )
      ];

      modifier = "Mod4";
      keybindings = lib.mkMerge [
        {
          "${modifier}+q" = "kill";
          "${modifier}+r" = "mode resize";
          "${modifier}+e" = "layout toggle split";
          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+Shift+Space" = "floating toggle";

          "${modifier}+v" = "splitv";
          "${modifier}+b" = "splith";

          "${modifier}+Space" = "exec ${lib.getExe pkgs.rofi} -show drun";
          "${modifier}+Return" = "exec ${lib.getExe pkgs.kitty}";
          "${modifier}+Shift+BackSpace" = "exec ${lib.getExe config.programs.swaylock.package}";

          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";
        }
        (lib.listToAttrs (map (w: lib.nameValuePair "${modifier}+${w}" "workspace number ${w}") workspaces))
        (lib.listToAttrs (
          map (
            w: lib.nameValuePair "${modifier}+Shift+${w}" "move container to workspace number ${w}"
          ) workspaces
        ))
      ];
    };
  };
}

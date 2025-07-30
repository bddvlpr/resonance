{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib)
    genList
    getExe
    listToAttrs
    mkMerge
    nameValuePair
    ;

  workspaces = genList (w: toString (w + 1)) 9;
in
{
  imports = [
    ./swaylock.nix
  ];

  wayland.windowManager.sway = {
    config = rec {
      defaultWorkspace = "1";

      terminal = getExe pkgs.kitty;

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
      keybindings = mkMerge [
        {
          "${modifier}+q" = "kill";
          "${modifier}+r" = "mode resize";
          "${modifier}+e" = "layout toggle split";
          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+Shift+Space" = "floating toggle";

          "${modifier}+v" = "splitv";
          "${modifier}+b" = "splith";

          "${modifier}+Space" = "exec ${getExe pkgs.rofi} -show drun";
          "${modifier}+Return" = "exec ${getExe pkgs.kitty}";
          "${modifier}+Shift+BackSpace" = "exec ${getExe config.programs.swaylock.package}";

          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";
        }
        (listToAttrs (map (w: nameValuePair "${modifier}+${w}" "workspace number ${w}") workspaces))
        (listToAttrs (
          map (w: nameValuePair "${modifier}+Shift+${w}" "move container to workspace number ${w}") workspaces
        ))
      ];
    };
  };
}

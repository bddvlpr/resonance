{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) concatLists genList getExe;

  mod = "SUPER";
in {
  wayland.windowManager.hyprland = {
    settings = {
      bind =
        [
          # General
          "${mod}, Q, killactive, "
          "${mod} SHIFT, Q, exit, "
          "${mod} SHIFT, BackSpace, exec, ${getExe config.programs.swaylock.package}"

          # Launchers
          "${mod}, Return, exec, ${getExe pkgs.foot}"
          "${mod}, Space, exec, ${getExe pkgs.rofi} -show drun"

          # Movement
          "${mod}, H, movefocus, l"
          "${mod}, J, movefocus, d"
          "${mod}, K, movefocus, u"
          "${mod}, L, movefocus, r"
          "${mod} SHIFT, Space, togglefloating, "
          "${mod}, S, togglesplit"
          "${mod}, E, swapnext"
          "${mod}, F, fullscreen, "
          "${mod}, P, pseudo, "

          # Resizing
          "${mod} SHIFT, H, resizeactive, -20 0"
          "${mod} SHIFT, J, resizeactive, 0 20"
          "${mod} SHIFT, K, resizeactive, 0 -20"
          "${mod} SHIFT, L, resizeactive, 20 0"

          # Grouping
          "${mod}, G, togglegroup"
          "${mod}, Tab, changegroupactive"

          # Special
          "${mod}, A, togglespecialworkspace"
          "${mod} SHIFT, A, movetoworkspace, special"

          # Meta
          ", XF86AudioRaiseVolume, exec, ${getExe pkgs.pamixer} -i 5"
          ", XF86AudioRaiseVolume, exec, ${getExe pkgs.pamixer} -d 5"
          ", XF86AudioPlay, exec, ${getExe pkgs.playerctl} play-pause"
          ", XF86AudioNext, exec, ${getExe pkgs.playerctl} next"
          ", XF86AudioPrev, exec, ${getExe pkgs.playerctl} previous"

          # Screenshotting
          "${mod} SHIFT, S, exec, ${getExe pkgs.grimblast} --notify copy area"
          "${mod} SHIFT, Print, exec, ${getExe pkgs.grimblast} --notify copy screen"
          "SHIFT, Print, exec, ${getExe pkgs.grimblast} --notify copy output"
          ", Print, exec, ${getExe pkgs.grimblast} --notify copy active"
        ]
        ++ (concatLists (
          genList (
            x: let
              ws = toString (x + 1);
            in [
              # Workspaces
              "${mod}, ${ws}, workspace, ${ws}"
              "${mod} SHIFT, ${ws}, movetoworkspace, ${ws}"
            ]
          )
          9
        ));
    };
  };

  services.hyprpaper = {
    enable = false;

    settings = let
      contour = pkgs.fetchurl {
        url = "https://github.com/rose-pine/wallpapers/blob/f76fd68629516ce820fe6dbcf31b5c44de78e4ad/rose_pine_contourline.png?raw=true";
        hash = "";
      };
    in {
      preload = [contour];
      wallpaper = [
        ", ${contour}"
      ];
    };
  };
}

{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) concatLists genList getExe;

  mod = "SUPER";
in {
  imports = [
    ./waybar.nix
  ];

  wayland.windowManager.hyprland = {
    settings = {
      input.follow_mouse = 2;
      dwindle.preserve_split = true;

      animations = {
        bezier = "fast, 0.05, 0.9, 0.1, 1";
        animation = [
          "windows, 1, 7, fast, slide"
          "workspaces, 1, 7, fast, slidefade"
        ];
      };

      bindm = [
        # Drag 'n Drop
        "${mod}, mouse:272, movewindow"
        "${mod}, mouse:273, resizewindow"
      ];

      bind =
        [
          # General
          "${mod}, Q, killactive, "
          "${mod} SHIFT, Q, exit, "
          "${mod} SHIFT, BackSpace, exec, ${getExe config.programs.hyprlock.package} --immediate"

          # Launchers
          "${mod}, Return, exec, ${getExe pkgs.kitty}"
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
}

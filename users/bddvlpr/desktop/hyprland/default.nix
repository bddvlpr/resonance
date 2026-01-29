{
  lib,
  config,
  pkgs,
  ...
}:
let
  mod = "SUPER";
in
{
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

      bind = [
        # General
        "${mod}, Q, killactive, "
        "${mod} SHIFT, Q, exit, "
        "${mod} SHIFT, BackSpace, exec, ${lib.getExe config.programs.hyprlock.package} --immediate"

        # Launchers
        "${mod}, Return, exec, ${lib.getExe pkgs.kitty}"
        "${mod}, Space, exec, ${lib.getExe pkgs.rofi} -show drun"

        # Movement
        "${mod} SHIFT, Space, togglefloating, "
        "${mod}, S, togglesplit"
        "${mod}, E, swapnext"
        "${mod}, F, fullscreen, "
        "${mod}, P, pseudo, "

        # Grouping
        "${mod}, G, togglegroup"
        "${mod}, Tab, changegroupactive"

        # Special
        "${mod}, A, togglespecialworkspace"
        "${mod} SHIFT, A, movetoworkspace, special"

        # Meta
        ", XF86AudioPlay, exec, ${lib.getExe pkgs.playerctl} play-pause"
        ", XF86AudioNext, exec, ${lib.getExe pkgs.playerctl} next"
        ", XF86AudioPrev, exec, ${lib.getExe pkgs.playerctl} previous"

        # Screenshotting
        "${mod} SHIFT, S, exec, ${lib.getExe pkgs.grimblast} --notify copy area"
        "${mod} SHIFT, Print, exec, ${lib.getExe pkgs.grimblast} --notify copy screen"
        "SHIFT, Print, exec, ${lib.getExe pkgs.grimblast} --notify copy output"
        ", Print, exec, ${lib.getExe pkgs.grimblast} --notify copy active"
      ]
      ++ (lib.concatLists (
        lib.genList (
          x:
          let
            ws = toString (x + 1);
          in
          [
            # Workspaces
            "${mod}, ${ws}, workspace, ${ws}"
            "${mod} SHIFT, ${ws}, movetoworkspace, ${ws}"
          ]
        ) 9
      ));

      binde = [
        # Media
        ", XF86AudioRaiseVolume, exec, ${lib.getExe pkgs.pamixer} -i 5"
        ", XF86AudioLowerVolume, exec, ${lib.getExe pkgs.pamixer} -d 5"

        # Backlight
        ", XF86MonBrightnessUp, exec, ${lib.getExe pkgs.brightnessctl} set +5%"
        ", XF86MonBrightnessDown, exec, ${lib.getExe pkgs.brightnessctl} set 5%-"

        # Resizing
        "${mod} SHIFT, H, resizeactive, -20 0"
        "${mod} SHIFT, J, resizeactive, 0 20"
        "${mod} SHIFT, K, resizeactive, 0 -20"
        "${mod} SHIFT, L, resizeactive, 20 0"

        # Movement
        "${mod}, H, movefocus, l"
        "${mod}, J, movefocus, d"
        "${mod}, K, movefocus, u"
        "${mod}, L, movefocus, r"
      ];

      misc = {
        enable_anr_dialog = false;
        middle_click_paste = false;
      };
    };
  };
}

{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib) filter forEach getExe mkIf mkOption optionals optionalString types;

  cfg = config.sysc.hyprland;
in {
  options.sysc.hyprland = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable Hyprland.";
    };

    dimmer = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Whether to enable a dimmer for your eyes if it goes dark.";
      };

      latitude = mkOption {
        type = types.float;
        default = 51.260197;
        description = "The latitude for sunset/sunrise calc.";
      };

      longitude = mkOption {
        type = types.float;
        default = 4.402771;
        description = "The longitude for sunset/sunrise calc.";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [xdg-utils imv];

    xdg.portal = let
      hyprland = config.wayland.windowManager.hyprland.package;
      xdph = pkgs.xdg-desktop-portal-hyprland.override {inherit hyprland;};
    in {
      extraPortals = [xdph];
      configPackages = [hyprland];
    };

    wayland.windowManager.hyprland = {
      enable = true;

      xwayland.enable = true;

      settings = {
        "$mod" = "SUPER";

        exec =
          [
            "${getExe pkgs.swaybg} -i ${config.stylix.image} --mode fill"
          ]
          ++ optionals cfg.dimmer.enable [
            "${getExe pkgs.wlsunset} -l ${toString cfg.dimmer.latitude} -L ${toString cfg.dimmer.longitude} -t 5500"
          ];

        general = {
          gaps_in = 4;
          gaps_out = 8;
          border_size = 2;
        };

        cursor = {
          no_hardware_cursors = true;
        };

        input = {
          sensitivity = -0.20;
          follow_mouse = 2;
        };

        dwindle = {
          preserve_split = true;
        };

        animations = {
          bezier = "fast, 0.05, 0.9, 0.1, 1";
          animation = [
            "windows, 1, 7, fast, slide"
            "workspaces, 1, 7, fast, slidefade"
          ];
        };

        windowrulev2 = let
          steam = "title:^()$,class:^(steam)$";
          steamapp = "class:^(steam_app)";
          cura_launcher = "title:^(cura)$";
          godot_new_node = "title:^(Create New Node)$,class:^(Godot)$";
        in [
          "stayfocused, ${steam}"
          "minsize 1 1, ${steam}"
          "tile, ${steamapp}"
          "float, ${cura_launcher}"
          "size 1300 800, ${godot_new_node}"
          "move center, ${godot_new_node}"
        ];

        bind = let
          pamixer = getExe pkgs.pamixer;
          playerctl = getExe pkgs.playerctl;
          grimblast = getExe pkgs.grimblast;
        in
          [
            "$mod, Q, killactive,"
            "$mod SHIFT, Q, exit,"
            "$mod SHIFT, BackSpace, exec, ${getExe config.programs.swaylock.package}"

            "$mod, Return, exec, ${getExe pkgs.foot}"
            "$mod, SPACE, exec, ${getExe pkgs.rofi} -show drun"

            "$mod SHIFT, SPACE, togglefloating,"
            "$mod, S, togglesplit"
            "$mod, E, swapnext"
            "$mod, F, fullscreen,"
            "$mod, P, pseudo,"

            "$mod, H, movefocus, l"
            "$mod, J, movefocus, d"
            "$mod, K, movefocus, u"
            "$mod, L, movefocus, r"

            "$mod SHIFT, H, resizeactive, -20 0"
            "$mod SHIFT, J, resizeactive, 0 20"
            "$mod SHIFT, K, resizeactive, 0 -20"
            "$mod SHIFT, L, resizeactive, 20 0"

            "$mod, G, togglegroup"
            "$mod, Tab, changegroupactive"

            "$mod, A, togglespecialworkspace"
            "$mod SHIFT, A, movetoworkspace, special"

            ", XF86AudioRaiseVolume, exec, ${pamixer} -i 5"
            ", XF86AudioLowerVolume, exec, ${pamixer} -d 5"
            "$mod SHIFT, XF86AudioRaiseVolume, exec, ${pamixer} --default-source -i 5"
            "$mod SHIFT, XF86AudioLowerVolume, exec, ${pamixer} --default-source -d 5"

            ", XF86AudioMute, exec, ${pamixer} -t"
            ", XF86AudioMicMute, exec, ${pamixer} --default-source -t"

            ", XF86AudioPlay, exec, ${playerctl} play-pause"
            ", XF86AudioNext, exec, ${playerctl} next"
            ", XF86AudioPrev, exec, ${playerctl} pause"

            "$mod SHIFT, S, exec, ${grimblast} --notify copy area"
            "$mod SHIFT, Print, exec, ${grimblast} --notify copy screen"
            "SHIFT, Print, exec, ${grimblast} --notify copy output"
            ", Print, exec, ${grimblast} --notify copy active"
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

        monitor = let
          mkMonitor = monitor: let
            inherit (monitor) enabled name width height refreshRate x y scale;
          in
            if enabled
            then "${name}, ${toString width}x${toString height}@${toString refreshRate}, ${toString x}x${toString y}, ${toString scale}"
            else "${name}, disabled";
        in
          [
            ", highres, auto, 1"
          ]
          ++ (forEach osConfig.sysc.monitors (m: mkMonitor m));

        workspace = let
          enabledWorkspaces = filter (m: m.enabled && m.workspace != null) osConfig.sysc.monitors;

          mkWorkspace = monitor: let
            inherit (monitor) workspace name;
          in "${optionalString (workspace != null) "name:${workspace}, monitor:${name}"}";
        in
          forEach enabledWorkspaces (m: mkWorkspace m);

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };
      };
    };

    home.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}

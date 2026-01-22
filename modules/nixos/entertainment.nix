{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.bowl.entertainment;
in
{
  options.bowl.entertainment = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = pkgs.stdenv.buildPlatform.isLinux;
      description = "Whether to enable entertainment packages.";
    };

    monado.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable Monado VR runtimes.";
    };

    wivrn.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable WiVRn VR runtimes.";
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        assertions = [
          {
            assertion = !(cfg.monado.enable && cfg.wivrn.enable);
            message = "Cannot run both WiVRn and Monado";
          }
        ];

        programs.steam = {
          enable = true;
          protontricks.enable = true;
          gamescopeSession.enable = true;
          extraPackages = with pkgs; [
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
            xorg.libxcb
            dotnet-sdk_9
            libpng
            libpulseaudio
            libvorbis
            sdl3
            stdenv.cc.cc.lib
            libkrb5
            libjack2
            keyutils
            procps
            usbutils
          ];
          extraCompatPackages = [
            pkgs.proton-ge-bin
          ];
        };

        programs.gamescope = {
          enable = true;
          capSysNice = false;
        };

        programs.gamemode = {
          enable = true;
          settings.general.renice = 10;
        };

        security.pam.loginLimits = [
          {
            domain = "*";
            item = "nofile";
            type = "soft";
            value = "1048576";
          }
          {
            domain = "*";
            item = "nofile";
            type = "hard";
            value = "1048576";
          }
          {
            domain = "@gamemode";
            type = "-";
            item = "rtprio";
            value = 98;
          }
          {
            domain = "@gamemode";
            type = "-";
            item = "memlock";
            value = "unlimited";
          }
          {
            domain = "@gamemode";
            type = "-";
            item = "nice";
            value = -11;
          }
        ];
      }
      (lib.mkIf cfg.monado.enable {
        services.monado = {
          enable = true;
          highPriority = true;
        };

        systemd.user.services.monado.environment = {
          STEAMVR_LH_ENABLE = "1";
          XRT_COMPOSITOR_COMPUTE = "1";
          WMR_HANDTRACKING = "0";
        };
      })
      (lib.mkIf cfg.wivrn.enable {
        services.wivrn = {
          enable = true;
          openFirewall = true;
          package = pkgs.wivrn.override { cudaSupport = true; };
          defaultRuntime = true;
        };
      })
    ]
  );
}

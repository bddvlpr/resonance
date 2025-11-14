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
  };

  config = lib.mkIf cfg.enable {
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
  };
}

{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) concatStringsSep getExe mkIf;

  cfg = config.bowl.desktop;

  sessionData = config.services.displayManager.sessionData.desktops;
  sessionPath = concatStringsSep ":" [
    "${sessionData}/share/xsessions"
    "${sessionData}/share/wayland-sessions"
  ];
in {
  config = mkIf (cfg.loginManager == "greetd") {
    services.greetd = {
      enable = true;

      vt = 2;
      restart = cfg.autoLogin == null;

      settings = {
        default_session = {
          user = "greeter";
          command = concatStringsSep " " [
            (getExe pkgs.greetd.tuigreet)
            "--time"
            "--remember"
            "--remember-user-session"
            "--asterisks"
            "--sessions '${sessionPath}'"
          ];
        };

        initial_session = mkIf (cfg.autoLogin.enable) {
          inherit (cfg.autoLogin) user;
          command = getExe cfg.autoLogin.package;
        };
      };
    };
  };
}

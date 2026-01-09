{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.bowl.desktop;

  sessionData = config.services.displayManager.sessionData.desktops;
  sessionPath = lib.concatStringsSep ":" [
    "${sessionData}/share/xsessions"
    "${sessionData}/share/wayland-sessions"
  ];
in
{
  config = lib.mkIf (cfg.loginManager == "greetd") {
    services.greetd = {
      enable = true;

      restart = cfg.autoLogin == null;

      settings = {
        default_session = {
          user = "greeter";
          command = lib.concatStringsSep " " [
            (lib.getExe pkgs.tuigreet)
            "--time"
            "--remember"
            "--remember-user-session"
            "--asterisks"
            "--sessions '${sessionPath}'"
          ];
        };

        initial_session = lib.mkIf (cfg.autoLogin.enable) {
          inherit (cfg.autoLogin) user command;
        };
      };
    };
  };
}

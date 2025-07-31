{
  self,
  lib,
  config,
  pkgs,
  ...
}:
{
  config =
    lib.mkIf
      (self.lib.hasHome config (v: v != null) [
        "bowl"
        "user"
        "git"
        "signing"
        "key"
      ])
      {
        programs.gnupg.agent = {
          enable = true;
          pinentryPackage = pkgs.pinentry-curses;
        };
      };
}

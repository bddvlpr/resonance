{
  self,
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (self.lib) hasHome;
  inherit (lib) mkIf;
in
{
  config =
    mkIf
      (hasHome config (v: v != null) [
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

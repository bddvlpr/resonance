{
  lib,
  self,
  config,
  ...
}:
let
  cfg = config.bowl.fingerprint;
in
{
  options.bowl.fingerprint = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable fingerprint authentication users.";
    };
  };
  config = lib.mkMerge [
    {
      security = {
        sudo = {
          enable = true;
          wheelNeedsPassword = false;
        };
        polkit.enable = true;
        pam.services = {
          hyprlock = lib.mkIf (self.lib.hasHome config (envs: lib.elem "hyprland" envs) [
            "bowl"
            "desktop"
            "environments"
          ]) { };
          swaylock = lib.mkIf (self.lib.hasHome config (envs: lib.elem "sway" envs) [
            "bowl"
            "desktop"
            "environments"
          ]) { };
        };
      };
    }
    (lib.mkIf cfg.enable {
      services.fprintd.enable = true;

      bowl.persist.entries = [
        { path = "/var/lib/fprint"; }
      ];
    })
  ];
}

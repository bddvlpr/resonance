{
  lib,
  self,
  config,
  ...
}: let
  inherit (self.lib) hasHome;
  inherit (lib) elem mkIf mkOption mkMerge types;

  cfg = config.bowl.fingerprint;
in {
  options.bowl.fingerprint = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable fingerprint authentication users.";
    };
  };
  config = mkMerge [
    {
      security.sudo = {
        enable = true;
        wheelNeedsPassword = false;
      };

      security.pam.services.hyprlock =
        mkIf (hasHome config (envs: elem "hyprland" envs) ["bowl" "desktop" "environments"]) {};
    }
    (mkIf cfg.enable {
      services.fprintd.enable = true;

      bowl.persist.entries = [
        {path = "/var/lib/fprint";}
      ];
    })
  ];
}

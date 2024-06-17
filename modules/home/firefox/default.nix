{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.firefox;
in {
  options.sysc.firefox = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable firefox.";
    };
  };

  config = mkIf cfg.enable {
    programs.firefox.enable = true;

    home = {
      sessionVariables.BROWSER = "firefox";
      persistence."/persist/home/bddvlpr" = {
        directories = [
          ".mozilla/firefox"
        ];
      };
    };
  };
}

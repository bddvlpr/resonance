{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.foot;
in {
  options.sysc.foot = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to use foot.";
    };

    defaultTerminal = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to use foot as the default terminal.";
    };
  };

  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          pad = "10x0";
        };
      };
    };

    home.sessionVariables.TERMINAL = mkIf cfg.defaultTerminal (lib.getExe pkgs.foot);
  };
}

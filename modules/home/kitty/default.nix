{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.kitty;
in {
  options.sysc.kitty = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to use kitty.";
    };

    defaultTerminal = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to use kitty as the default terminal.";
    };
  };

  config = mkIf cfg.enable {
    programs.kitty.enable = true;
    home.sessionVariables.TERMINAL = mkIf cfg.defaultTerminal (lib.getExe pkgs.kitty);
  };
}

{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.direnv;
in {
  options.sysc.direnv = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable direnv.";
    };

    enableNixDirenv = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable nix-direnv integration.";
    };
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = cfg.enableNixDirenv;
    };

    home.persistence."/persist/home/bddvlpr".directories = [".local/share/direnv"];
  };
}

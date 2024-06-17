{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.gpg;
in {
  options.sysc.gpg = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable gpg.";
    };

    mutable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to allow changes in keys or trust.";
    };
  };

  config = mkIf cfg.enable {
    programs.gpg = {
      enable = true;

      mutableKeys = cfg.mutable;
      mutableTrust = cfg.mutable;

      publicKeys = [
        {
          source = ./bddvlpr-2023-08-08.asc;
          trust = "ultimate";
        }
      ];
    };
  };
}

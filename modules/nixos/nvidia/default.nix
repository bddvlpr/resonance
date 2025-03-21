{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.nvidia;
in
{
  options.sysc.nvidia = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable Nvidia stuff.";
    };

    enableBeta = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable the beta driver.";
    };

    enableOpen = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable the open driver.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ nvtopPackages.nvidia ];

    hardware.nvidia = {
      package = mkIf cfg.enableBeta config.boot.kernelPackages.nvidiaPackages.beta;
      open = cfg.enableOpen;
      modesetting.enable = true;
      nvidiaSettings = false;
    };
  };
}

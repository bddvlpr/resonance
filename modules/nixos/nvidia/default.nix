{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.nvidia;
in {
  options.sysc.nvidia = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enabe Nvidia stuff.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [nvtopPackages.nvidia];

    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = true;
      nvidiaSettings = false;
    };
  };
}

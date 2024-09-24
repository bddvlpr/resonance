{
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.sysc.aagl;
in {
  imports = [inputs.aagl.nixosModules.default];

  options.sysc.aagl = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable aagl.";
    };
  };

  config = mkIf cfg.enable {
    programs = {
      honkers-railway-launcher.enable = true;
      wavey-launcher.enable = true;
      sleepy-launcher.enable = true;
    };
  };
}

{
  lib,
  config,
  inputs,
  ...
}: let
  inherit (lib) mkIf mkOption types;
  inherit (inputs.aagl-gtk-on-nix.nixosModules) default;

  cfg = config.sysc.aagl;
in {
  imports = [default];

  options.sysc.aagl = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable aagl.";
    };
  };

  config = mkIf cfg.enable {
    programs.honkers-railway-launcher.enable = true;
  };
}

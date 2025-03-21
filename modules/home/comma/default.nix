{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (inputs.nix-index-database.hmModules) nix-index;
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.comma;
in
{
  imports = [ nix-index ];

  options.sysc.comma = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable Comma.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ comma ];
  };
}

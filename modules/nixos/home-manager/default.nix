{
  inputs,
  inputs',
  outputs,
  lib,
  config,
  self',
  system,
  ...
}:
let
  inherit (inputs.home-manager.nixosModules) home-manager;
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.home-manager;
in
{
  imports = [ home-manager ];

  options.sysc.home-manager = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable home-manager.";
    };
  };

  config = mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;

      users.bddvlpr = import ./users/bddvlpr.nix;
      extraSpecialArgs = {
        inherit
          inputs
          inputs'
          outputs
          self'
          system
          ;
      };
    };
  };
}

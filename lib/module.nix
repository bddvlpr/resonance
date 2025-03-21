{
  self,
  lib,
  inputs,
  withSystem,
  ...
}:
let
  inherit (self) outputs;
  inherit (lib.strings) hasSuffix;
in
{
  flake.lib = rec {
    mkPkgs =
      system:
      import inputs.nixpkgs {
        inherit system;
        overlays = [
          outputs.overlays.pkgs
          inputs.nur.overlays.default
        ];
        config.allowUnfree = true;
      };

    mkSystem =
      host: system: type: modules:
      withSystem system (
        {
          pkgs,
          inputs',
          self',
          ...
        }:
        type {
          inherit system modules;
          pkgs = mkPkgs system;
          specialArgs = {
            inherit
              inputs
              inputs'
              outputs
              self
              host
              ;
          };
        }
      );

    mkStrappedSystem =
      host: system: type: modules:
      let
        inherit (builtins) attrValues;

        isLinux = hasSuffix "linux" system;
      in
      mkSystem host system type (
        modules
        ++ (if isLinux then attrValues outputs.nixosModules else attrValues outputs.darwinModules)
        ++ attrValues outputs.sharedModules
      );
  };
}

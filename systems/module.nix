{
  self,
  inputs,
  lib,
  withSystem,
  ...
}: let
  inherit (self) outputs;
  inherit (inputs.nixpkgs.lib) nixosSystem;

  mkSystem = host: system:
    withSystem system ({pkgs, ...}: {
      "${host}" = nixosSystem {
        inherit pkgs system;
        specialArgs = {inherit inputs outputs;};
        modules =
          [
            ./${host}
            ./${host}/hardware.nix
          ]
          ++ builtins.attrValues outputs.nixosModules;
      };
    });
in {
  flake.nixosConfigurations = lib.mkMerge [
    (mkSystem "apollo" "x86_64-linux")
  ];
}

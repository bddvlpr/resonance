{
  self,
  inputs,
  lib,
  withSystem,
  ...
}: let
  inherit (self) outputs;
  inherit (inputs.nixpkgs.lib) nixosSystem;

  mkPkgs = system:
    import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

  mkSystem = host: system:
    withSystem system ({pkgs, ...}: {
      "${host}" = nixosSystem {
        inherit system;
        pkgs = mkPkgs system;
        specialArgs = {inherit inputs outputs host;};
        modules =
          [
            ./${host}
            ./${host}/hardware.nix
          ]
          ++ builtins.attrValues outputs.nixosModules
          ++ builtins.attrValues outputs.sharedModules;
      };
    });
in {
  flake.nixosConfigurations = lib.mkMerge [
    (mkSystem "dissension" "x86_64-linux")
  ];
}

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
      overlays = with outputs.overlays; [pkgs];
      config.allowUnfree = true;
    };

  mkNixOS = host: system:
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

  mkDarwin = host: system:
    withSystem system ({pkgs, ...}: {
      "${host}" = inputs.nix-darwin.lib.darwinSystem {
        inherit system;
        pkgs = mkPkgs system;
        specialArgs = {inherit inputs outputs host;};
        modules =
          []
          ++ builtins.attrValues outputs.darwinModules
          ++ builtins.attrValues outputs.sharedModules;
      };
    });
in {
  flake = {
    nixosConfigurations = lib.mkMerge [
      (mkNixOS "dissension" "x86_64-linux")
      (mkNixOS "solaris" "x86_64-linux")
    ];

    darwinConfigurations = lib.mkMerge [
      (mkDarwin "lavender" "x86_64-darwin")
    ];
  };
}

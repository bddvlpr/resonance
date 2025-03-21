{
  self,
  lib,
  inputs,
  ...
}:
let
  inherit (self) outputs;
  inherit (outputs.lib) mkStrappedSystem;
  inherit (lib) mkMerge;
  inherit (inputs.nixpkgs.lib) nixosSystem;
  inherit (inputs.nix-darwin.lib) darwinSystem;

  mkNixOS = host: system: {
    "${host}" = mkStrappedSystem host system nixosSystem [
      ./${host}
      ./${host}/hardware.nix
    ];
  };

  mkDarwin = host: system: {
    "${host}" = mkStrappedSystem host system darwinSystem [
      ./${host}
    ];
  };
in
{
  flake = {
    nixosConfigurations = mkMerge [
      (mkNixOS "dissension" "x86_64-linux")
      (mkNixOS "solaris" "x86_64-linux")
    ];

    darwinConfigurations = mkMerge [
      (mkDarwin "lavender" "x86_64-darwin")
    ];
  };
}

{
  description = "Luna's system configurations and modules";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";
    flake-parts.url = "github:hercules-ci/flake-parts";
    impermanence.url = "github:nix-community/impermanence";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:lnl7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.inputs.home-manager.follows = "home-manager";

    lemonake.url = "github:passivelemon/lemonake";
    lemonake.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {flake-parts, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      imports = [
        ./apps/module.nix
        ./checks/module.nix
        ./modules/module.nix
        ./overlays/module.nix
        ./pkgs/module.nix
        ./systems/module.nix
      ];

      perSystem = {pkgs, ...}: {
        formatter = pkgs.alejandra;
      };
    };
}

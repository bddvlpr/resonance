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

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.inputs.home-manager.follows = "home-manager";

    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";

    lemonake.url = "github:passivelemon/lemonake";
    lemonake.inputs.nixpkgs.follows = "nixpkgs";

    snippets-ls.url = "github:quantonganh/snippets-ls";
    snippets-ls.inputs.nixpkgs.follows = "nixpkgs";

    aagl-gtk-on-nix.url = "github:ezkea/aagl-gtk-on-nix";
    aagl-gtk-on-nix.inputs.nixpkgs.follows = "nixpkgs";

    steel.url = "github:mattwparas/steel";
    steel.inputs.nixpkgs.follows = "nixpkgs";

    helix-steel.url = "github:mattwparas/helix/steel-event-system";
    helix-steel.inputs.nixpkgs.follows = "nixpkgs";
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

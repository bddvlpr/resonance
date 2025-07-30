{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    crane.url = "github:ipetkov/crane";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    advisory-db = {
      url = "github:rustsec/advisory-db";
      flake = false;
    };
  };

  outputs =
    {
      flake-parts,
      crane,
      advisory-db,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];

      perSystem =
        {
          pkgs,
          inputs',
          self',
          ...
        }:
        let
          craneToolchain = inputs'.fenix.packages.latest.toolchain;
          craneLib = (crane.mkLib pkgs).overrideToolchain craneToolchain;

          src = craneLib.cleanCargoSource ./.;

          commonArgs = {
            inherit src;
            strictDeps = true;

            buildInputs = [ ];
          };

          cargoArtifacts = craneLib.buildDepsOnly commonArgs;
        in
        {
          formatter = pkgs.alejandra;

          packages = {
            package = craneLib.buildPackage (
              commonArgs
              // {
                inherit cargoArtifacts;
              }
            );
          };

          checks = self'.packages // {
            workspace-clippy = craneLib.cargoClippy (
              commonArgs
              // {
                inherit cargoArtifacts;
                cargoClippyExtraArgs = "--all-targets -- --deny warnings";
              }
            );

            workspace-doc = craneLib.cargoDoc (
              commonArgs
              // {
                inherit cargoArtifacts;
              }
            );

            workspace-fmt = craneLib.cargoFmt {
              inherit src;
            };

            workspace-toml-fmt = craneLib.taploFmt {
              src = pkgs.lib.sources.sourceFilesBySuffices src [ ".toml" ];
            };

            workspace-audit = craneLib.cargoAudit {
              inherit src advisory-db;
            };

            workspace-deny = craneLib.cargoDeny {
              inherit src;
            };

            workspace-nextest = craneLib.cargoNextest (
              commonArgs
              // {
                inherit cargoArtifacts;
                partitions = 1;
                partitionType = "count";
                cargoNextestPartitionsExtraArgs = "--no-tests=pass";
              }
            );
          };

          devShells.default = craneLib.devShell {
            checks = self'.checks;
          };
        };
    };
}

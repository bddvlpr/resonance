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

  outputs = {
    flake-parts,
    crane,
    advisory-db,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];

      perSystem = {
        pkgs,
        lib,
        inputs',
        self',
        ...
      }: let
        craneToolchain = inputs'.fenix.packages.latest.toolchain;
        craneLib = (crane.mkLib pkgs).overrideToolchain craneToolchain;

        src = craneLib.cleanCargoSource ./.;

        commonArgs = {
          inherit src;
          strictDeps = true;

          buildInputs = [];
        };

        cargoArtifacts = craneLib.buildDepsOnly commonArgs;

        individualCrateArgs =
          commonArgs
          // {
            inherit cargoArtifacts;
            inherit (craneLib.crateNameFromCargoToml {inherit src;}) version;
            doCheck = false;
          };

        fileSetForCrate = crate:
          lib.fileset.toSource {
            root = ./.;
            fileset = lib.fileset.unions [
              ./Cargo.toml
              ./Cargo.lock
              (craneLib.fileset.commonCargoSources crate)
            ];
          };
      in {
        formatter = pkgs.alejandra;

        packages = {
          package-a = craneLib.buildPackage (individualCrateArgs
            // {
              pname = "package-a";
              cargoExtraArgs = "-p package-a";
              src = fileSetForCrate ./crates/package-a;
            });

          package-b = craneLib.buildPackage (individualCrateArgs
            // {
              pname = "package-b";
              cargoExtraArgs = "-p package-b";
              src = fileSetForCrate ./crates/package-b;
            });
        };

        checks =
          self'.packages
          // {
            workspace-clippy = craneLib.cargoClippy (commonArgs
              // {
                inherit cargoArtifacts;
                cargoClippyExtraArgs = "--all-targets -- --deny warnings";
              });

            workspace-doc = craneLib.cargoDoc (commonArgs
              // {
                inherit cargoArtifacts;
              });

            workspace-fmt = craneLib.cargoFmt {
              inherit src;
            };

            workspace-toml-fmt = craneLib.taploFmt {
              src = pkgs.lib.sources.sourceFilesBySuffices src [".toml"];
            };

            workspace-audit = craneLib.cargoAudit {
              inherit src advisory-db;
            };

            workspace-deny = craneLib.cargoDeny {
              inherit src;
            };

            workspace-nextest = craneLib.cargoNextest (commonArgs
              // {
                inherit cargoArtifacts;
                partitions = 1;
                partitionType = "count";
                cargoNextestPartitionsExtraArgs = "--no-tests=pass";
              });
          };

        devShells.default = craneLib.devShell {
          checks = self'.checks;
        };
      };
    };
}

{lib, ...}: let
  inherit (lib) listToAttrs nameValuePair;

  mkTemplate = name: description:
    nameValuePair name {
      path = ./${name};
      inherit description;
    };
in {
  flake.templates = listToAttrs [
    (mkTemplate "rust" "Rust package using crane")
    (mkTemplate "rust-workspace" "Rust workspace using crane")
  ];
}

{ lib, ... }:
let
  mkTemplate =
    name: description:
    lib.nameValuePair name {
      path = ./${name};
      inherit description;
    };
in
{
  flake.templates = lib.listToAttrs [
    (mkTemplate "rust" "Rust package using crane")
    (mkTemplate "rust-workspace" "Rust workspace using crane")
  ];
}

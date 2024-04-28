{inputs, ...}: let
  inherit (inputs.disko.nixosModules) disko;
in {
  imports = [
    disko
    ./luks-btrfs.nix
  ];
}

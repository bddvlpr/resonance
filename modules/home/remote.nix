{ inputs, ... }:
{
  imports = [
    inputs.nix-index-database.homeModules.nix-index
  ];
}

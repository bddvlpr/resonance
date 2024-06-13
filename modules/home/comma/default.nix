{
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs.nix-index-database.hmModules) nix-index;
in {
  imports = [nix-index];

  home.packages = with pkgs; [comma];
}

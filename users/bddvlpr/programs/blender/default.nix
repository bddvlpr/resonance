{ pkgs, ... }:
{
  home.packages = [ pkgs.blender ];

  bowl.persist.entries = [
    { path = ".config/blender"; }
  ];
}

{ pkgs, ... }:
{
  home.packages = [ pkgs.gimp-with-plugins ];

  bowl.persist.entries = [
    { path = ".config/GIMP"; }
    { path = ".cache/gimp"; }
  ];
}

{ pkgs, ... }:
{
  home.packages = [ pkgs.minio-client ];

  bowl.persist.entries = [
    { from = ".mc"; }
  ];
}

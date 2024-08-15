{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkMerge;
  inherit (pkgs.stdenv) isDarwin;
in {
  users.users.bddvlpr = mkMerge [
    {
      shell = pkgs.fish;
    }
    (mkIf (!isDarwin) {
      isNormalUser = true;
      extraGroups = ["wheel" "audio" "video" "dialout" "networkmanager" "docker"];
      hashedPassword = "$y$j9T$loVbb4dcOYqZmhAC3NScI1$NmvBmCrmuybhIhaM25x6.X2AgFKkvk9Upfr8GyqCA.3";
    })
    (mkIf isDarwin {
      home = "/Users/bddvlpr";
    })
  ];
}

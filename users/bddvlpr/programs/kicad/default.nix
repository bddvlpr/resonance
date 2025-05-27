{pkgs, ...}: {
  home.packages = [pkgs.kicad];

  bowl.persist.entries = [
    {path = ".config/kicad";}
    {path = ".cache/kicad";}
    {path = ".local/share/kicad";}
  ];
}

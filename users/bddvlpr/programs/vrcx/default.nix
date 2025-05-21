{pkgs, ...}: {
  home.packages = [pkgs.vrcx];

  bowl.persist.entries = [
    {path = ".config/VRCX";}
  ];
}

{ pkgs, ... }:
{
  home.packages = [ pkgs.bambu-studio ];

  xdg.desktopEntries = {
    bambu-studio-nogpu = {
      name = "BambuStudio (No GPU)";
      genericName = "3D Printing Software";
      exec = "env GBM_BACKEND=dri bambu-studio";
      icon = "BambuStudio";
    };
  };

  bowl.persist.entries = [
    { from = ".config/BambuStudio"; }
    { from = ".cache/bambu-studio"; }
    { from = ".local/share/bambu-studio"; }
  ];
}

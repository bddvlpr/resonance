{pkgs, ...}: {
  home = {
    packages = with pkgs; [gimp-with-plugins];
    persistence."/persist/home/bddvlpr".directories = [
      ".config/GIMP"
      ".cache/gimp"
    ];
  };
}

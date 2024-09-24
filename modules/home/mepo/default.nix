{pkgs, ...}: {
  home = {
    packages = [pkgs.mepo];
    persistence."/persist/home/bddvlpr".directories = [
      ".cache/mepo"
    ];
  };
}

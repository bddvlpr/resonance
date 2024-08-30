{pkgs, ...}: {
  home = {
    packages = [pkgs.sdrangel];
    persistence."/persist/home/bddvlpr".directories = [".config/f4exb"];
  };
}

{pkgs, ...}: {
  home = {
    packages = with pkgs; [blender];
    persistence."/persist/home/bddvlpr".directories = [
      ".config/blender"
    ];
  };
}

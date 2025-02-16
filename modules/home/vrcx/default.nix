{pkgs, ...}: {
  home = {
    packages = with pkgs; [vrcx];
    persistence."/persist/home/bddvlpr".directories = [
      ".config/VRCX"
    ];
  };
}

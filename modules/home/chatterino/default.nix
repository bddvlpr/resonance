{pkgs, ...}: {
  home = {
    packages = [pkgs.chatterino2];
    persistence."/persist/home/bddvlpr".directories = [
      ".local/share/chatterino"
    ];
  };
}

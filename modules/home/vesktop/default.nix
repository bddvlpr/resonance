{pkgs, ...}: {
  home = {
    packages = with pkgs; [vesktop];
    persistence."/persist/home/bddvlpr" = {
      directories = [".config/vesktop"];
    };
  };
}

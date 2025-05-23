{pkgs, ...}: {
  programs.zoxide = {
    enable = true;
    options = ["--cmd cd"];
  };

  home.packages = with pkgs; [comma];

  bowl.persist.entries = [
    {path = ".local/share/zoxide";}
  ];
}

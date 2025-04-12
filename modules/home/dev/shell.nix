{
  pkgs,
  inputs,
  ...
}: {
  imports = [];

  programs.zoxide = {
    enable = true;
    options = ["--cmd cd"];
  };

  home.packages = with pkgs; [comma];
}

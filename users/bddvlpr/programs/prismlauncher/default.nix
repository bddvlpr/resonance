{ pkgs, ... }:
{
  home.packages = [ pkgs.prismlauncher ];

  bowl.persist.entries = [
    { from = ".local/share/PrismLauncher"; }
  ];
}

{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [ prismlauncher ];
    persistence."/persist/home/bddvlpr".directories = [
      ".local/share/PrismLauncher"
    ];
  };
}

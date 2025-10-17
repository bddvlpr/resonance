{ pkgs, ... }:
{
  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  home.packages = with pkgs; [
    bun
    comma
    htop
    fastfetch
    nodejs
    pnpm
    wrangler
  ];

  bowl.persist.entries = [
    { path = ".local/share/zoxide"; }
  ];
}

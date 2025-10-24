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
    freerdp
    nodejs
    pnpm
    step-cli
    wrangler
  ];

  bowl.persist.entries = [
    { path = ".local/share/zoxide"; }
    { path = ".step"; }
  ];
}

{ pkgs, ... }:
{
  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  home.packages = with pkgs; [
    biome
    bun
    comma
    fastfetch
    freerdp
    htop
    nodejs
    openssl
    pnpm
    step-cli
    wrangler
  ];

  bowl.persist.entries = [
    { from = ".local/share/zoxide"; }
    { from = ".step"; }
  ];
}

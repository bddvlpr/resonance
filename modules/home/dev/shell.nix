{ pkgs, ... }:
{
  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  home.packages = with pkgs; [
    crystal
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
  ];

  bowl.persist.entries = [
    { from = ".local/share/zoxide"; }
    { from = ".step"; }
  ];
}

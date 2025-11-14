{ pkgs, ... }:
{
  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  home.packages = with pkgs; [
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
    { path = ".local/share/zoxide"; }
    { path = ".step"; }
  ];
}

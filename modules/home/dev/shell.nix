{ pkgs, ... }:
{
  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  home.packages = with pkgs; [
    biome
    bun
    cargo
    comma
    crystal
    fastfetch
    ffmpeg
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

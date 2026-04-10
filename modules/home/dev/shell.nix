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
    nixpkgs-review
    nodejs
    openssl
    pnpm
    step-cli
    thunar
  ];

  bowl.persist.entries = [
    { from = ".local/share/zoxide"; }
    { from = ".step"; }
  ];
}

{
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs.stylix.homeManagerModules) stylix;
in {
  imports = [stylix];

  stylix = {
    enable = true;
    image = ./wallpaper.jpeg;

    polarity = "dark";

    opacity = {
      desktop = 0.8;
      terminal = 0.8;
      popups = 0.6;
    };

    cursor = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
    };

    fonts = {
      serif = {
        package = pkgs.eb-garamond;
        name = "EB Garamond";
      };

      sansSerif = {
        package = pkgs.geist-font;
        name = "Geist";
      };

      monospace = {
        package = pkgs.geist-mono-nerd-font;
        name = "GeistMono NFM";
      };

      emoji = {
        package = pkgs.twitter-color-emoji;
        name = "Twitter Color Emoji";
      };
    };

    targets.vscode.enable = false;
  };

  home.packages = with pkgs; [
    noto-fonts-cjk-sans
    (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
  ];
}

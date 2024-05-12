{
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs.stylix.homeManagerModules) stylix;
in {
  imports = [stylix];

  stylix = {
    image = ./wallpaper.jpeg;

    polarity = "dark";

    opacity = {
      desktop = 0.8;
      terminal = 0.8;
      popups = 0.6;
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

      emoji = {
        package = pkgs.twitter-color-emoji;
        name = "Twitter Color Emoji";
      };
    };
  };
}

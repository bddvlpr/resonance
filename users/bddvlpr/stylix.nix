{
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.stylix.homeModules.stylix ];

  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
    polarity = "dark";
    image = pkgs.fetchurl {
      url = "https://github.com/rose-pine/wallpapers/blob/main/rose_pine_contourline.png?raw=true";
      hash = "sha256-8OQCXMy27IImp1Oc/X4i14/8k9XjuuU+6clh0rRcAQY=";
    };

    cursor = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      size = 32;
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
        package = pkgs.nerd-fonts.geist-mono;
        name = "GeistMono Nerd Font";
      };

      emoji = {
        package = pkgs.twitter-color-emoji;
        name = "Twitter Color Emoji";
      };
    };

    targets.firefox.profileNames = [
      "personal"
      "work"
    ];
  };
}

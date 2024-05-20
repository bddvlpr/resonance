{pkgs, ...}: {
  home.packages = with pkgs; [nodejs] ++ (with nodePackages; [yarn pnpm]);
}

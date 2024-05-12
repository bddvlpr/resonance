{pkgs, ...}: let
  inherit (pkgs) callPackage;
in {
  geist-mono-nerd-font = callPackage ./geist-mono-nerd-font {};
}

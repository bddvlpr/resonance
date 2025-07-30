{
  self,
  config,
  ...
}:
let
  inherit (self.lib) hasHome;
  hasShell =
    shell:
    hasHome config (v: v.enable) [
      "programs"
      shell
    ];
in
{
  programs = {
    fish.enable = hasShell "fish";
  };
}

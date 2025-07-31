{
  self,
  config,
  ...
}:
let
  hasShell =
    shell:
    self.lib.hasHome config (v: v.enable) [
      "programs"
      shell
    ];
in
{
  programs = {
    fish.enable = hasShell "fish";
  };
}

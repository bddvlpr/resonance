{
  perSystem = {pkgs, ...} @ args: {
    packages = import ./. args;
  };
}

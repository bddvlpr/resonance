args: {
  perSystem = {pkgs, ...} @ sysArgs: {
    packages = import ./. (args // sysArgs);
  };
}

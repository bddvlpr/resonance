{pkgs, ...} @ args: {
  programs.zed-editor = {
    enable = true;
    extraPackages = with pkgs; [nil nixd];

    userSettings = import ./settings.nix args;
    extensions = [
      "nix"
    ];
  };
}

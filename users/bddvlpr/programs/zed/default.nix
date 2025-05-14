{pkgs, ...} @ args: {
  programs.zed-editor = {
    enable = true;
    extraPackages = with pkgs; [
      nil
      nixd
      package-version-server
    ];

    userSettings = import ./settings.nix args;
    extensions = [
      # Languages
      "nix"

      # Styles
      "rose-pine-theme"
    ];
  };

  bowl.persist.entries = [
    {path = ".cache/zed";}
    {path = ".local/share/zed";}
  ];
}

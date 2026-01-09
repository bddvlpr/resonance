{ pkgs, ... }@args:
{
  programs.zed-editor = {
    enable = true;
    extraPackages = with pkgs; [
      nil
      nixd
      package-version-server
      rust-analyzer
      zed-discord-presence
    ];

    userSettings = import ./settings.nix args;
    extensions = [
      # Languages
      "nix"
      "svelte"

      # Styles
      "rose-pine-theme"
    ];
  };

  bowl.persist.entries = [
    { from = ".cache/zed"; }
    { from = ".local/share/zed"; }
  ];
}

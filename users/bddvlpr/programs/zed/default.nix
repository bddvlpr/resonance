{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
    ];

    extraPackages = with pkgs; [nil nixd];
  };
}

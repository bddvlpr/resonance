{pkgs, ...}: {
  programs.vscode = {
    enable = true;

    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;

    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      kamadorueda.alejandra

      rust-lang.rust-analyzer
      tamasfe.even-better-toml

      editorconfig.editorconfig
      usernamehw.errorlens
      eamodio.gitlens
      esbenp.prettier-vscode
      dbaeumer.vscode-eslint
    ];
  };
}

{
  programs.firefox.enable = true;

  home = {
    sessionVariables.BROWSER = "firefox";
    persistence."/persist/home/bddvlpr" = {
      directories = [
        ".mozilla/firefox"
      ];
    };
  };
}

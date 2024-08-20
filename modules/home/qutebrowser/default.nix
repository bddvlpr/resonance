{
  programs.qutebrowser = {
    enable = true;

    searchEngines = {
      nw = "https://wiki.nixos.org/index.php?search={}";
      g = "https://www.google.com/search?hl=en&q={}";
      gh = "https://github.com/search?q={}&type=repositories";
    };
  };
}

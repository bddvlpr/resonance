{pkgs, ...}: {
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark-qt;
  };

  environment.systemPackages = [pkgs.termshark];
}

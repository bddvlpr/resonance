{pkgs, ...}: {
  users.users.bddvlpr = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = ["wheel" "audio" "video" "network"];
    hashedPassword = "$y$j9T$loVbb4dcOYqZmhAC3NScI1$NmvBmCrmuybhIhaM25x6.X2AgFKkvk9Upfr8GyqCA.3";
  };
}

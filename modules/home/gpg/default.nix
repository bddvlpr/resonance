{
  programs.gpg = {
    enable = true;

    mutableKeys = false;
    mutableTrust = false;

    publicKeys = [
      {
        source = ./bddvlpr-2023-08-08.asc;
        trust = "ultimate";
      }
    ];
  };
}

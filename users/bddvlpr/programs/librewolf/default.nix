{ ... }@args:
{
  programs.librewolf = {
    enable = true;
    languagePacks = [ "en-US" ];

    policies = {
      DisableFormHistory = true;
      DisableFirefoxStudies = true;
      DisableTelemetry = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        Stories = false;
        SponsoredPocket = false;
        SponsoredStories = false;
        Snippets = false;
        Locked = true;
      };
      PasswordManagerEnabled = false;
    };

    profiles = {
      personal = import ./personal args;
      work = import ./work args;
    };
  };

  bowl.persist.entries = [
    { from = ".librewolf"; }
    { from = ".cache/librewolf"; }
  ];
}

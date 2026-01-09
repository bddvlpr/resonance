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

    settings = {
      "privacy.clearOnShutdown.cache" = true;
      "privacy.clearOnShutdown.cookies" = false;
      "privacy.clearOnShutdown.downloads" = true;
      "privacy.clearOnShutdown.formdata" = true;
      "privacy.clearOnShutdown.history" = true;
      "privacy.clearOnShutdown.offlineApps" = false;
      "privacy.clearOnShutdown.openWindows" = true;
      "privacy.clearOnShutdown.sessions" = true;
      "privacy.clearOnShutdown.siteSettings" = false;
      "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = true;
      "privacy.clearOnShutdown_v2.cache" = true;
      "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
      "privacy.clearOnShutdown_v2.formdata" = true;
      "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = true;
      "privacy.clearOnShutdown_v2.siteSettings" = false;
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

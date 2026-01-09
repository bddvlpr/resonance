{ pkgs, ... }:
{
  programs.firefox = {
    enable = pkgs.stdenv.buildPlatform.isLinux;

    profiles = {
      personal = import ./personal;
      work = import ./work;
    };

    policies = {
      DisablePocket = true;
      DisplayBookmarksToolbar = true;
      DisableFirefoxStudies = true;
      DisableTelemetry = true;
      PasswordManagerEnabled = false;
      FirefoxHome = {
        Search = true;
        Pocket = false;
        Snippets = false;
        TopSites = false;
        Highlights = false;
        SponsoredPocket = false;
        SponsoredTopSites = false;
      };
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      ExtensionSettings = {
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
        "firefox@ghostery.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ghostery/latest.xpi";
          installation_mode = "force_installed";
        };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          installation_mode = "force_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };

  bowl.persist.entries = [
    { from = ".mozilla/firefox"; }
  ];
}

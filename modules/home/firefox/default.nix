{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption types;

  cfg = config.sysc.firefox;
in {
  options.sysc.firefox = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to enable firefox.";
    };
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;

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

      profiles = {
        Personal = {
          id = 0;

          search = {
            force = true;
            engines = {
              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                    definedAliases = ["@np"];
                  }
                ];
              };
              "Nix Options" = {
                urls = [
                  {
                    template = "https://search.nixos.org/options";
                    params = [
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                    definedAliases = ["@no"];
                  }
                ];
              };
            };
          };

          bookmarks = [
            {
              name = "Toolbar";
              toolbar = true;
              bookmarks = [
                {
                  name = "Entertainment";
                  bookmarks = [
                    {
                      name = "Ceres";
                      bookmarks = [
                        {
                          name = "Prowlarr";
                          url = "http://ceres:9696";
                        }
                        {
                          name = "Sonarr";
                          url = "http://ceres:8989";
                        }
                        {
                          name = "Radarr";
                          url = "http://ceres:7878";
                        }
                        {
                          name = "Flood";
                          url = "http://ceres:9091";
                        }
                        {
                          name = "Bazarr";
                          url = "http://ceres:6767";
                        }
                        {
                          name = "Jellyfin";
                          url = "http://ceres:8096";
                        }
                        {
                          name = "Jellyseerr";
                          url = "http://ceres:5055";
                        }
                      ];
                    }
                  ];
                }
                {
                  name = "Services";
                  bookmarks = [
                    {
                      name = "Assistant";
                      url = "https://assistant.bddvlpr.com/";
                    }
                    {
                      name = "Cloud";
                      url = "https://cloud.bddvlpr.com/";
                    }
                    {
                      name = "Monitor";
                      url = "https://monitoring.bddvlpr.com/";
                    }
                  ];
                }
                {
                  name = "Development";
                  bookmarks = [
                    {
                      name = "Web";
                      bookmarks = [
                        {
                          name = "TailwindCSS docs";
                          url = "https://tailwindcss.com/docs/";
                        }
                        {
                          name = "Svelte docs";
                          url = "https://svelte.dev/docs/introduction";
                        }
                        {
                          name = "Svelte5 docs";
                          url = "https://svelte-5-preview.vercel.app/docs/introduction";
                        }
                        {
                          name = "TypeScript docs";
                          url = "https://www.typescriptlang.org/docs/";
                        }
                      ];
                    }
                    {
                      name = "Typst";
                      bookmarks = [
                        {
                          name = "Typst app";
                          url = "https://typst.app/";
                        }
                        {
                          name = "Typst docs";
                          url = "https://typst.app/docs/";
                        }
                        {
                          name = "Typst universe";
                          url = "https://typst.app/universe/";
                        }
                      ];
                    }
                    {
                      name = "Nix";
                      bookmarks = [
                        {
                          name = "Nix(OS) manual (stable)";
                          url = "https://nixos.org/manual/nixos/stable/";
                        }
                        {
                          name = "Nix(OS) manual (unstable)";
                          url = "https://nixos.org/manual/nixos/unstable/";
                        }
                        {
                          name = "Home manager options";
                          url = "https://nix-community.github.io/home-manager/options.xhtml";
                        }
                        {
                          name = "Noogle";
                          url = "https://noogle.dev/";
                        }
                        {
                          name = "Nixpkgs";
                          url = "https://github.com/nixos/nixpkgs";
                        }
                        {
                          name = "Resonance";
                          url = "https://github.com/bddvlpr/resonance";
                        }
                        {
                          name = "Fidelity";
                          url = "https://github.com/bddvlpr/fidelity";
                        }
                      ];
                    }
                    {
                      name = "GitHub";
                      url = "https://github.com/";
                    }
                  ];
                }
                {
                  name = "Radio";
                  bookmarks = [
                    {
                      name = "SondeHub";
                      url = "https://v2.sondehub.org/";
                    }
                    {
                      name = "SondeHub amateur";
                      url = "https://amateur.sondehub.org/";
                    }
                    {
                      name = "Meshtastic client";
                      url = "https://client.meshtastic.org/";
                    }
                    {
                      name = "Meshmap";
                      url = "https://meshmap.net";
                    }
                  ];
                }
              ];
            }
            {
              name = "Entertainment";
              bookmarks = [
                {
                  name = "YouTube";
                  url = "https://youtube.com/";
                }
                {
                  name = "Twitch";
                  url = "https://twitch.tv/";
                }
              ];
            }
          ];
        };
      };
    };

    home = {
      sessionVariables.BROWSER = "firefox";
      persistence."/persist/home/bddvlpr" = {
        directories = [
          ".mozilla/firefox"
        ];
      };
    };
  };
}

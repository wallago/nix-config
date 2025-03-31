{ pkgs, ... }:
{
  environment.sessionVariables = {
    BROWSER = "firefox";
  };

  programs.firefox = {
    enable = true;
    languagePacks = [
      "en-US"
    ];
    policies = {
      DefaultDownloadDirectory = "~/Downloads"; # -> Set the default download directory.
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      }; # ----------------------------------------> Configure tracking protection.
      DisableTelemetry = true; # ------------------> Prevent the upload of telemetry data.
      DisableFirefoxStudies = true; # -------------> Disable Firefox studies (Shield).
      DisablePocket = true; # ---------------------> Remove Pocket in the Firefox UI.
      DisableFirefoxAccounts = true; # ------------> Disable Firefox Accounts integration (Sync).
      DisableFirefoxScreenshots = true; # ---------> Remove access to Firefox Screenshots.
      OverrideFirstRunPage = ""; # ----------------> Override the first run page.
      OverridePostUpdatePage = ""; # --------------> Override the upgrade page.
      DontCheckDefaultBrowser = true; # -----------> Don’t check if Firefox is the default browser at startup.
      BlockAboutConfig = true; # ------------------> Block access to about:config.
      DisablePasswordReveal = true; # -------------> Do not allow passwords to be shown in saved logins.
      PrimaryPassword = true; # -------------------> Require or prevent using a primary (formerly master) password.
      HttpsOnlyMode = "enabled"; # ----------------> Configure HTTPS-Only Mode.
      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://mozilla.cloudflare-dns.com/dns-query";
        Locked = true;
      }; # ----------------------------------------> Configure DNS over HTTPS (DoH).
      SearchBar = "separate"; # -------------------> Set whether or not search bar is displayed.
      SearchEngines = {
        Default = "DuckDuckGo"; # Set the default search engine. This policy is only available on the ESR.
        Remove = [ "Google" ];
        PreventInstalls = false; # Prevent installing search engines from webpages.
      };
      ExtensionSettings = {
        "*".installation_mode = "blocked"; # ------> Blocks all addons except below
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        }; # --------------------------------------> Automatically learns to block invisible trackers.
        "jid1-ZAdIEUB7XOzOJw@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi";
          installation_mode = "force_installed";
        }; # --------------------------------------> Simple and seamless privacy protection for your browser: tracker blocking, cookie protection, DuckDuckGo private search, email protection, HTTPS upgrading, and much more.
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        }; # --------------------------------------> Wide-spectrum content blocker.
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
          installation_mode = "force_installed";
        }; # --------------------------------------> The Hacker's Browser.
        "newtaboverride@agenedia.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/new-tab-override/latest.xpi";
          installation_mode = "force_installed";
        }; # --------------------------------------> New Tab Override allows you to set the page that shows whenever you open a new tab.
      };
      Preferences = {
        "browser.theme.content-theme" = 0;
        "browser.startup.homepage" = "https://homepage-brown-ten.vercel.app/";
        "browser.urlbar.suggest.searches" = {
          Value = false;
          Status = "locked";
        };
        "browser.urlbar.showSearchSuggestionsFirst" = {
          Value = false;
          Status = "locked";
        };
        "browser.search.suggest.enabled" = {
          Value = false;
          Status = "locked";
        };
        "browser.search.suggest.enabled.private" = {
          Value = false;
          Status = "locked";
        };
        "browser.formfill.enable" = {
          Value = false;
          Status = "locked";
        };
        "browser.contentblocking.category" = {
          Value = "strict";
          Status = "locked";
        };
        "browser.topsites.contile.enabled" = {
          Value = false;
          Status = "locked";
        };
        "browser.newtabpage.activity-stream.feeds.section.topstories" = {
          Value = false;
          Status = "locked";
        };
        "browser.newtabpage.activity-stream.feeds.snippets" = {
          Value = false;
          Status = "locked";
        };
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = {
          Value = false;
          Status = "locked";
        };
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = {
          Value = false;
          Status = "locked";
        };
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = {
          Value = false;
          Status = "locked";
        };
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = {
          Value = false;
          Status = "locked";
        };
        "browser.newtabpage.activity-stream.showSponsored" = {
          Value = false;
          Status = "locked";
        };
        "browser.newtabpage.activity-stream.system.showSponsored" = {
          Value = false;
          Status = "locked";
        };
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = {
          Value = false;
          Status = "locked";
        };
        "extensions.screenshots.disabled" = {
          Value = true;
          Status = "locked";
        };
        "extensions.pocket.enabled" = {
          Value = false;
          Status = "locked";
        };
        "identity.fxaccounts.enabled" = {
          Value = false;
          Status = "locked";
        };
        "media.peerconnection.enabled" = {
          Value = false;
          Status = "locked";
        };
        "reader.parse-on-load.enabled" = {
          Value = true;
          Status = "locked";
        };
        "zoom.defaultPercent" = 100;
        "privacy.resistFingerprinting" = {
          Value = true;
          Status = "locked";
        };
        "privacy.trackingprotection.fingerprinting.enabled" = {
          Value = true;
          Status = "locked";
        };
        "privacy.trackingprotection.cryptomining.enabled" = {
          Value = true;
          Status = "locked";
        };
      };
    };
  };
}

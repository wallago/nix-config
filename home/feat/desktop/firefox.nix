{ pkgs, ... }:
{
  home.sessionVariables = {
    BROWSER = "firefox";
  };

  programs.browserpass.enable = true; # Browser extension designed to securely integrate the Unix-based password manager pass

  programs.firefox = {
    enable = true;
    profiles.default = {
      search = {
        force = true;
        default = "DuckDuckGo";
        privateDefault = "DuckDuckGo";
        order = [
          "Kagi"
          "DuckDuckGo"
          "Google"
        ];
        engines = {
          "Kagi" = {
            urls = [ { template = "https://kagi.com/search?q={searchTerms}"; } ];
            iconUpdateURL = "https://kagi.com/favicon.ico";
          };
          "Bing".metaData.hidden = true;
        };
      };
      bookmarks = { };
      extensions.packages = with pkgs.inputs.firefox-addons; [
        ublock-origin
        browserpass
      ];
      bookmarks = { };
      settings = {
        "browser.startup.homepage" = "about:home";

        # Disable irritating first-run stuff
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.feeds.showFirstRunUI" = false;
        "browser.messaging-system.whatsNewPanel.enabled" = false;
        "browser.rights.3.shown" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.uitour.enabled" = false;
        "startup.homepage_override_url" = "";
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.bookmarks.addedImportButton" = true;

        # Don't ask for download dir
        "browser.download.useDownloadDir" = false;

        # Disable crappy home activity stream page
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
        "browser.newtabpage.blocked" = lib.genAttrs [
          # Youtube
          "26UbzFJ7qT9/4DhodHKA1Q=="
          # Facebook
          "4gPpjkxgZzXPVtuEoAL9Ig=="
          # Wikipedia
          "eV8/WsSLxHadrTL1gAxhug=="
          # Reddit
          "gLv0ja2RYVgxKdp0I5qwvA=="
          # Amazon
          "K00ILysCaEq8+bEqV/3nuw=="
          # Twitter
          "T9nJot5PurhJSy8n038xGA=="
        ] (_: 1);

        # Disable some telemetry
        "app.shield.optoutstudies.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.sessions.current.clean" = true;
        "devtools.onboarding.telemetry.logged" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.updatePing.enabled" = false;

        # Disable fx accounts
        "identity.fxaccounts.enabled" = false;
        # Disable "save password" prompt
        "signon.rememberSignons" = false;
        # Harden
        "privacy.trackingprotection.enabled" = true;
        "dom.security.https_only_mode" = true;
        # Layout
        "browser.uiCustomization.state" = builtins.toJSON {
          currentVersion = 20;
          newElementCount = 5;
          dirtyAreaCache = [
            "nav-bar"
            "PersonalToolbar"
            "toolbar-menubar"
            "TabsToolbar"
            "widget-overflow-fixed-list"
          ];
          placements = {
            PersonalToolbar = [ "personal-bookmarks" ];
            TabsToolbar = [
              "tabbrowser-tabs"
              "new-tab-button"
              "alltabs-button"
            ];
            nav-bar = [
              "back-button"
              "forward-button"
              "stop-reload-button"
              "urlbar-container"
              "downloads-button"
              "ublock0_raymondhill_net-browser-action"
              "_testpilot-containers-browser-action"
              "reset-pbm-toolbar-button"
              "unified-extensions-button"
            ];
            toolbar-menubar = [ "menubar-items" ];
            unified-extensions-area = [ ];
            widget-overflow-fixed-list = [ ];
          };
          seen = [
            "save-to-pocket-button"
            "developer-button"
            "ublock0_raymondhill_net-browser-action"
            "_testpilot-containers-browser-action"
          ];
        };
      };
    };
  };
  # programs.firefox = {
  #   enable = true;
  #   languagePacks = [
  #     "en-US"
  #   ];
  #   policies = {
  #     DefaultDownloadDirectory = "~/Downloads"; # -> Set the default download directory.
  #     EnableTrackingProtection = {
  #       Value = true;
  #       Locked = true;
  #       Cryptomining = true;
  #       Fingerprinting = true;
  #     }; # ----------------------------------------> Configure tracking protection.
  #     DisableTelemetry = true; # ------------------> Prevent the upload of telemetry data.
  #     DisableFirefoxStudies = true; # -------------> Disable Firefox studies (Shield).
  #     DisablePocket = true; # ---------------------> Remove Pocket in the Firefox UI.
  #     DisableFirefoxAccounts = true; # ------------> Disable Firefox Accounts integration (Sync).
  #     DisableFirefoxScreenshots = true; # ---------> Remove access to Firefox Screenshots.
  #     OverrideFirstRunPage = ""; # ----------------> Override the first run page.
  #     OverridePostUpdatePage = ""; # --------------> Override the upgrade page.
  #     DontCheckDefaultBrowser = true; # -----------> Don’t check if Firefox is the default browser at startup.
  #     BlockAboutConfig = true; # ------------------> Block access to about:config.
  #     DisablePasswordReveal = true; # -------------> Do not allow passwords to be shown in saved logins.
  #     PrimaryPassword = true; # -------------------> Require or prevent using a primary (formerly master) password.
  #     HttpsOnlyMode = "enabled"; # ----------------> Configure HTTPS-Only Mode.
  #     DNSOverHTTPS = {
  #       Enabled = true;
  #       ProviderURL = "https://mozilla.cloudflare-dns.com/dns-query";
  #       Locked = true;
  #     }; # ----------------------------------------> Configure DNS over HTTPS (DoH).
  #     SearchBar = "separate"; # -------------------> Set whether or not search bar is displayed.
  #     SearchEngines = {
  #       Default = "DuckDuckGo"; # Set the default search engine. This policy is only available on the ESR.
  #       Remove = [ "Google" ];
  #       PreventInstalls = false; # Prevent installing search engines from webpages.
  #     };
  #     ExtensionSettings = {
  #       "*".installation_mode = "blocked"; # ------> Blocks all addons except below
  #       pkgs.inputs.
  #       # "jid1-MnnxcxisBPnSXQ@jetpack" = {
  #       #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
  #       #   installation_mode = "force_installed";
  #       # }; # --------------------------------------> Automatically learns to block invisible trackers.
  #       # "jid1-ZAdIEUB7XOzOJw@jetpack" = {
  #       #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi";
  #       #   installation_mode = "force_installed";
  #       # }; # --------------------------------------> Simple and seamless privacy protection for your browser: tracker blocking, cookie protection, DuckDuckGo private search, email protection, HTTPS upgrading, and much more.
  #       # "uBlock0@raymondhill.net" = {
  #       #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
  #       #   installation_mode = "force_installed";
  #       # }; # --------------------------------------> Wide-spectrum content blocker.
  #       # "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
  #       #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
  #       #   installation_mode = "force_installed";
  #       # }; # --------------------------------------> The Hacker's Browser.
  #       # "newtaboverride@agenedia.com" = {
  #       #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/new-tab-override/latest.xpi";
  #       #   installation_mode = "force_installed";
  #       # }; # --------------------------------------> New Tab Override allows you to set the page that shows whenever you open a new tab.
  #     };
  #     Preferences = {
  #       "browser.theme.content-theme" = 0;
  #       "browser.startup.homepage" = "https://homepage-brown-ten.vercel.app/";
  #       "browser.urlbar.suggest.searches" = {
  #         Value = false;
  #         Status = "locked";
  #       };
  #       "browser.urlbar.showSearchSuggestionsFirst" = {
  #         Value = false;
  #         Status = "locked";
  #       };
  #       "browser.search.suggest.enabled" = {
  #         Value = false;
  #         Status = "locked";
  #       };
  #       "browser.search.suggest.enabled.private" = {
  #         Value = false;
  #         Status = "locked";
  #       };
  #       "browser.formfill.enable" = {
  #         Value = false;
  #         Status = "locked";
  #       };
  #       "browser.contentblocking.category" = {
  #         Value = "strict";
  #         Status = "locked";
  #       };
  #       "browser.topsites.contile.enabled" = {
  #         Value = false;
  #         Status = "locked";
  #       };
  #       "browser.newtabpage.activity-stream.feeds.section.topstories" = {
  #         Value = false;
  #         Status = "locked";
  #       };
  #       "browser.newtabpage.activity-stream.feeds.snippets" = {
  #         Value = false;
  #         Status = "locked";
  #       };
  #       "browser.newtabpage.activity-stream.section.highlights.includePocket" = {
  #         Value = false;
  #         Status = "locked";
  #       };
  #       "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = {
  #         Value = false;
  #         Status = "locked";
  #       };
  #       "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = {
  #         Value = false;
  #         Status = "locked";
  #       };
  #       "browser.newtabpage.activity-stream.section.highlights.includeVisited" = {
  #         Value = false;
  #         Status = "locked";
  #       };
  #       "browser.newtabpage.activity-stream.showSponsored" = {
  #         Value = false;
  #         Status = "locked";
  #       };
  #       "browser.newtabpage.activity-stream.system.showSponsored" = {
  #         Value = false;
  #         Status = "locked";
  #       };
  #       "browser.newtabpage.activity-stream.showSponsoredTopSites" = {
  #         Value = false;
  #         Status = "locked";
  #       };
  #       "extensions.screenshots.disabled" = {
  #         Value = true;
  #         Status = "locked";
  #       };
  #       "extensions.pocket.enabled" = {
  #         Value = false;
  #         Status = "locked";
  #       };
  #       "identity.fxaccounts.enabled" = {
  #         Value = false;
  #         Status = "locked";
  #       };
  #       "media.peerconnection.enabled" = {
  #         Value = false;
  #         Status = "locked";
  #       };
  #       "reader.parse-on-load.enabled" = {
  #         Value = true;
  #         Status = "locked";
  #       };
  #       "zoom.defaultPercent" = 100;
  #       "privacy.resistFingerprinting" = {
  #         Value = true;
  #         Status = "locked";
  #       };
  #       "privacy.trackingprotection.fingerprinting.enabled" = {
  #         Value = true;
  #         Status = "locked";
  #       };
  #       "privacy.trackingprotection.cryptomining.enabled" = {
  #         Value = true;
  #         Status = "locked";
  #       };
  #     };
  #   };
  # };
}

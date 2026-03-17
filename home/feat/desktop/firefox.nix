{ ... }:
{
  home.sessionVariables = {
    BROWSER = "firefox";
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };

  programs.browserpass.enable = true; # Browser extension designed to securely integrate the Unix-based password manager pass

  programs.firefox = {
    enable = true;
    languagePacks = [ "en-US" ];
    policies = {
      BlockAboutConfig = false;
      DefaultDownloadDirectory = "\${home}/Downloads";
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      }; # --------------------------------> Configure tracking protection.
      DisableTelemetry = true; # ----------> Prevent the upload of telemetry data.
      DisableFirefoxStudies = true; # -----> Disable Firefox studies (Shield).
      DisablePocket = true; # -------------> Remove Pocket in the Firefox UI.
      DisableFirefoxAccounts = true; # ----> Disable Firefox Accounts integration (Sync).
      DisableFirefoxScreenshots = true; # -> Remove access to Firefox Screenshots.
      DontCheckDefaultBrowser = true; # ---> Don’t check if Firefox is the default browser at startup.
      DisablePasswordReveal = true; # -----> Do not allow passwords to be shown in saved logins.
      HttpsOnlyMode = "enabled"; # --------> Configure HTTPS-Only Mode.
      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://mozilla.cloudflare-dns.com/dns-query";
        Locked = true;
      }; # --------------------------------> Configure DNS over HTTPS (DoH).
      Preferences = {
        # Homepage
        "browser.startup.homepage" = "https://rewind.henrotte.xyz/";
        "startup.homepage_override_url" = "";
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.newtabpage.enabled" = false;

        # UI Customization
        "browser.uiCustomization.state" = builtins.toJSON {
          placements = {
            unified-extensions-area = [ ];
            widget-overflow-fixed-list = [ ];
            nav-bar = [
              "back-button"
              "forward-button"
              "vertical-spacer"
              "stop-reload-button"
              "urlbar-container"
              "downloads-button"
              "ublock0_raymondhill_net-browser-action"
              "_testpilot-containers-browser-action"
              "reset-pbm-toolbar-button"
              "unified-extensions-button"
            ];
            toolbar-menubar = [ "menubar-items" ];
            TabsToolbar = [ ];
            vertical-tabs = [ "tabbrowser-tabs" ];
            PersonalToolbar = [ "personal-bookmarks" ];
          };
          seen = [
            "save-to-pocket-button"
            "developer-button"
            "ublock0_raymondhill_net-browser-action"
            "_testpilot-containers-browser-action"
            "screenshot-button"
          ];
          dirtyAreaCache = [
            "nav-bar"
            "PersonalToolbar"
            "toolbar-menubar"
            "TabsToolbar"
            "widget-overflow-fixed-list"
            "vertical-tabs"
          ];
          currentVersion = 23;
          newElementCount = 10;
        };

        # General UX
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.bookmarks.addedImportButton" = true;
        "browser.uitour.enabled" = false;
        "browser.feeds.showFirstRunUI" = false;
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "reader.parse-on-load.enabled" = true;

        # Search / Suggestions
        "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.showSearchSuggestionsFirst" = false;
        "browser.search.suggest.enabled" = false;
        "browser.search.suggest.enabled.private" = false;

        # Forms & Autofill
        "browser.formfill.enable" = false;

        # Privacy & Security
        "privacy.resistFingerprinting" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "dom.security.https_only_mode" = false;
        "signon.rememberSignons" = false;
        "media.peerconnection.enabled" = true;
        "browser.contentblocking.category" = "strict";

        # Disable Firefox Account
        "identity.fxaccounts.enabled" = false;

        # Disable Pocket & Sponsored Content
        "extensions.pocket.enabled" = false;
        "extensions.screenshots.disabled" = true;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.system.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
        "browser.topsites.contile.enabled" = false;

        # Download behavior
        "browser.download.useDownloadDir" = false;

        # Disable telemetry
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.server" = "";
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

        # Zoom
        "zoom.defaultPercent" = 100;

        # Dev
        "devtools.toolbox.host" = "right";

        # Remove close button
        "browser.tabs.inTitlebar" = 0;

        # Vertical tabs
        "sidebar.verticalTabs" = true;
        "sidebar.revamp" = true;
        "sidebar.main.tools" = [
          "history"
          "bookmarks"
        ];
      };
    };
  };
}

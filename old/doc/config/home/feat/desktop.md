# 📦 System packages

- `environment.systemPackdages`
  - `wl-clipboard`\
    ▶️ clipboard utilities (copy/paste support under Wayland)
  - `wf-recorder`\
    ▶️ screen recording of wlroots-based compositors
  - `pkgs.handlr-regex`\
    ▶️ manage default applications
  - `pkgs.swaybg`\
    ▶️ wallpaper tool for Wayland compositors
  - `pkgs.brightnessctl`\
    ▶️ read and control device brightness
  - `pkgs.grimblast`\
    ▶️ helper for screenshots within Hyprland, based on grimshot
  - `pkgs.pulseaudio`\
    ▶️ sound server for POSIX and Win32 systems
  - `pkgs.coreutils`\
    ▶️ GNU Core Utilities
  - `pkgs.gnugrep`\
    ▶️ GNU implementation of the Unix grep command
  - `pkgs.systemd`\
    ▶️ system and service manager for Linux
  - `pkgs.jq`\
    ▶️ lightweight and flexible command-line JSON processor
  - `pkgs.playerctl`\
    ▶️ utility and library for controlling media players that implement MPRIS
  - `pkgs.util-linux`\
    ▶️ set of system utilities for Linux
  - `pkgs.procps`\
    ▶️ utilities that give information about processes using the /proc filesystem
  - `pkgs.swaylock-effects`\
    ▶️ screen locker for Wayland

# 🖼️ XDG Integration

- `xdg`
  - `mimeApps`
    - `enable = true`\
       ▶️ enables support for default applications via MIME types (e.g., opening PDFs, URLs, etc.)
    - `associations.added = { "x-scheme-handler/terminal" = "Ghostty.desktop"; }`\
      ▶️ associates `x-scheme-handler/terminal` with Ghostty
    - `defaultApplications`
      - `"x-scheme-handler/terminal" = "Ghostty.desktop"`\
         ▶️ sets Ghostty as the default terminal for terminal schemes
      - `"text/html" = [ "firefox.desktop" ]`
      - `"text/xml" = [ "firefox.desktop" ]`
      - `"x-scheme-handler/http" = [ "firefox.desktop" ]`
      - `"x-scheme-handler/https" = [ "firefox.desktop" ]`\
        ▶️ sets Firefox as the default handler for web-related MIME types
  - `portal`\
    - `enable = true`
      ▶️ enables xdg-desktop-portal for Wayland integration
    - `extraPortals = [ pkgs.xdg-desktop-portal-wlr ]`
      ▶️ adds support for wlroots-based compositors
  - `xdg.desktopEntries.Ghostty`
    - `name = "Ghostty"`\
      ▶️ desktop entry name for Ghostty
    - `exec = "ghostty"`\
      ▶️ command to run Ghostty
    - `terminal = false`\
      ▶️ indicates it's a terminal app but doesn't spawn in a terminal
    - `mimeType = [ "x-scheme-handler/terminal" ]`\
      ▶️ handles terminal scheme URIs
    - `categories = [ "System" "Utility" ]`\
      ▶️ menu classification

# 🏠 Home Configuration

- `home.sessionVariables`
  - `MOZ_ENABLE_WAYLAND = 1`\
    ▶️ enables Wayland for Firefox
  - `QT_QPA_PLATFORM = "wayland"`\
    ▶️ forces Qt apps to use Wayland
  - `LIBSEAT_BACKEND = "logind"`\
    ▶️ sets seat management backend to `logind`
  - `BROWSER = "firefox"`\
    ▶️ sets Firefox as the default browser for the session

# 🪟 Hyprland Window Manager

- `wayland.windowManager.hyprland`
  - `enable = true`\
    ▶️ enables the Hyprland compositor
  - `systemd.enable = true`\
    ▶️ enables systemd integration for Hyprland session management
  - `settings`
    - `general = import ./general.nix { inherit config rgba; }`\
      ▶️ general compositor settings, with color utility via `rgba`
    - `cursor = import ./cursor.nix`\
      ▶️ cursor style and behavior settings
    - `group = import ./group.nix { inherit config rgba; }`\
      ▶️ group management configuration (e.g., tabbed windows)
    - `binds = import ./binds.nix`\
      ▶️ general bindings (separate from keybindings)
    - `input = import ./input.nix`\
      ▶️ input device configuration (keyboard, mouse, etc.)
    - `dwindle = import ./dwindle.nix`\
      ▶️ tiling engine configuration for dwindle layout
    - `misc = import ./misc.nix`\
      ▶️ various miscellaneous Hyprland settings
    - `windowrulev2 = import ./windowrulev2.nix { inherit lib rgba; }`\
      ▶️ advanced window rules for managing window behavior
    - `layerrule = import ./layerrule.nix`\
      ▶️ rules for handling layer surfaces (e.g., overlays)
    - `decoration = import ./decoration`\
      ▶️ window decorations like borders and shadows
    - `animations = import ./animations`\
      ▶️ controls Hyprland’s animation behavior
    - `exec = import ./exec.nix { inherit pkgs config; }`\
      ▶️ autostart programs and initialization
    - `monitor = import ./monitor.nix { inherit config; }`\
      ▶️ monitor layout and configuration
    - `workspace = import ./workspace.nix { inherit config lib; }`\
      ▶️ workspace naming, default assignments, etc.
    - `bind = import ./keybindings { inherit config lib pkgs; }`\
      ▶️ keybinding configuration (e.g., mod+Enter, mod+Q)

# 🎛️ Waybar Configuration

- `programs.waybar`
  - `enable = true`\
    ▶️ enables the Waybar status bar
  - `package = pkgs.waybar.overrideAttrs (...)`\
    ▶️ enables experimental features via `-Dexperimental=true` Meson flag
  - `style = import ./style.nix { inherit lib config inputs; }`\
    ▶️ loads custom style configuration
  - `systemd.enable = true`\
    ▶️ enables systemd support for Waybar
  - `settings.primary`
    - `exclusive = false`\
      ▶️ bar does not exclusively reserve screen space
    - `passthrough = false`\
      ▶️ disables click passthrough
    - `height = 40`, `margin = "6"`, `position = "top"`\
      ▶️ sets bar dimensions and position
    - `modules = { ... }`

# 🪟 Ghostty Terminal Configuration

- `programs.ghostty`
  - `enable = true`\
    ▶️ enables Ghostty via Home Manager
  - `enableFishIntegration = true`\
    ▶️ enables shell integration with Fish
  - `settings`
    - `theme = "custom"`\
      ▶️ uses a custom theme (defined below)
    - `font-size = config.fontProfiles.monospace.size`\
      ▶️ inherits font size from profile
    - `font-family = config.fontProfiles.monospace.name`\
      ▶️ inherits font family from profile
    - `window-padding-x = "6"`\
      ▶️ horizontal padding for window
    - `window-padding-y = "4"`\
      ▶️ vertical padding for window
    - `confirm-close-surface = false`\
      ▶️ disables confirmation dialog on close
  - `themes.custom`
    ▶️ defines custom 16-color palette from your theme's color scheme

# 🌐 Firefox Configuration

- `programs.firefox`
  - `enable = true`
  - `languagePacks = [ "en-US" ]`
  - `policies`
    - `BlockAboutConfig = true`\
      ▶️ blocks about:config access
    - `DefaultDownloadDirectory = "\${home}/Downloads"`\
      ▶️ sets the default download location
    - `EnableTrackingProtection = { Value = true; Locked = true; ... }`\
      ▶️ enforces strict tracking protection, including cryptomining and fingerprinting
    - `DisableTelemetry = true`\
      ▶️ disables telemetry
    - `DisableFirefoxStudies = true`\
      ▶️ disables Mozilla experiments
    - `DisablePocket = true`\
      ▶️ removes Pocket integration
    - `DisableFirefoxAccounts = true`\
      ▶️ disables Firefox Account features like Sync
    - `DisableFirefoxScreenshots = true`\
      ▶️ removes Firefox Screenshots
    - `DontCheckDefaultBrowser = true`\
      ▶️ suppresses default browser checks
    - `DisablePasswordReveal = true`\
      ▶️ hides saved passwords from being revealed
    - `HttpsOnlyMode = "enabled"`\
      ▶️ enables HTTPS-only mode
    - `DNSOverHTTPS = { Enabled = true; ProviderURL = "..."; Locked = true; }`\
      ▶️ enables and locks DoH with Cloudflare
    - `Preferences`
      - `browser.startup.homepage = "https://homepage-brown-ten.vercel.app/"`
      - `browser.newtabpage.enabled = false`
      - `browser.uiCustomization.state = ...`\
        ▶️ applies custom toolbar layout
      - `browser.disableResetPrompt = true`
      - `browser.download.panel.shown = true`
      - `browser.shell.defaultBrowserCheckCount = 1`
      - `browser.uitour.enabled = false`
      - `trailhead.firstrun.didSeeAboutWelcome = true`
      - `reader.parse-on-load.enabled = true`
      - `browser.urlbar.suggest.searches = false`
      - `browser.search.suggest.enabled.private = false`
      - `browser.formfill.enable = false`
      - `privacy.trackingprotection.enabled = true`
      - `privacy.resistFingerprinting = true`
      - `media.peerconnection.enabled = false`
      - `signon.rememberSignons = false`
      - `browser.contentblocking.category = "strict"`
      - `identity.fxaccounts.enabled = false`
      - `extensions.pocket.enabled = false`
      - `extensions.screenshots.disabled = true`
      - `browser.newtabpage.activity-stream.* = false`\
        ▶️ disables all sponsored and suggested content
      - `browser.download.useDownloadDir = false`
      - `toolkit.telemetry.* = false`\
        ▶️ disables all telemetry and reporting
      - `zoom.defaultPercent = 100`\
        ▶️ sets default zoom level

# 🔐 Browserpass Configuration

- `programs.browserpass.enable = true`\
  ▶️ enables `browserpass`, which integrates the Unix `pass` password manager with the browser

# 📋 Cliphist Configuration

- `services.cliphist.enable = true`\
  ▶️ enables a clipboard history “manager” for wayland

  # 🌇 GammaStep Configuration

- `services.gammastep`
  - `enable = true`\
    ▶️ enables adjustement screen coloration temperature based on time of day
  - `enableVerboseLogging = true`\
    ▶️ logs detailed debug output (helpful for troubleshooting)
  - `provider = "geoclue2"`\
    ▶️ uses GeoClue to automatically detect your location for sunrise/sunset times
  - `temperature`
    - `day = 6000`\
      ▶️ sets color temperature to 6000K during daytime (neutral white)
    - `night = 4600`\
      ▶️ sets color temperature to 4600K at night (warmer tones for eye comfort)
  - `settings.general.adjustment-method = "wayland"`\
    ▶️ specifies Wayland as the screen adjustment method

# 🖼️ imv Image Viewer Configuration

- `programs.imv.enable = true`\
  ▶️ enables `imv`, a lightweight and minimal image viewer for X11 and Wayland

# 📄 Zathura PDF Viewer Configuration

- `programs.zathura`
  - `enable = true`  
    ▶️ enables `zathura`, a lightweight and highly customizable PDF viewer
  - `options = { ... }`

# 🔒 Swaylock Configuration

- `programs.swaylock`
  - `enable = true`  
    ▶️ enables `swaylock`, the screen locker for Wayland
  - `package = pkgs.swaylock-effects`  
    ▶️ uses the `swaylock-effects` fork to enable visual enhancements like blur
  - `settings = { ... }`

# 💤 Swayidle configuration

- `services.swayidle`
  - `enable = true`  
    ▶️ enables `swayidle`, a daemon that runs commands when idle (lock, dim, turn off screen)
  - `systemdTarget = "graphical-session.target"`  
    ▶️ ensures swayidle is started with the graphical session
  - `timeouts`
    - `timeout = 240`
    - `command = "${swaylock} -i ${config.wallpaper} --daemonize --grace 15 --grace-no-mouse"`  
      ▶️ invokes `swaylock` with a wallpaper and a 15s grace period without mouse movement
    - `timeout = 280` (i.e., 240s lockTime + 40s)
    - `command = "${hyprctl} dispatch dpms off"`
    - `resumeCommand = "${hyprctl} dispatch dpms on"`  
      ▶️ powers off and back on displays after lock if idle continues
    - `timeout = 40`
    - `command = "${isLocked} && ${hyprctl} dispatch dpms off"`  
      ▶️ double-checks if already locked before DPMS off
    - `timeout = 280`
    - `command = "${swaymsg} 'output * dpms off'"`
    - `resumeCommand = "${swaymsg} 'output * dpms on'"`  
      ▶️ same logic but using `swaymsg` for Sway
    - `timeout = 40`
    - `command = "${isLocked} && ${swaymsg} 'output * dpms off'"`  
      ▶️ conditional display off if locked

# 🔔 Mako Notification Daemon Configuration

- `services.mako`
  - `enable = true`  
    ▶️ enables the `mako` notification daemon for Wayland compositors
  - `font = "${config.fontProfiles.regular.name} ${config.fontProfiles.regular.size}"`  
    ▶️ sets the font used in notifications
  - `padding = "10,20"`  
    ▶️ adds vertical and horizontal padding around the notification content
  - `anchor = "top-center"`  
    ▶️ positions notifications at the top center of the screen
  - `width = 400`  
    ▶️ sets the maximum notification width
  - `height = 150`  
    ▶️ sets the maximum notification height
  - `borderSize = 2`  
    ▶️ defines the border thickness around notifications
  - `defaultTimeout = 12000`  
    ▶️ sets default timeout for notifications to 12 seconds (in milliseconds)
  - `backgroundColor = "${colors.surface}dd"`  
    ▶️ sets the semi-transparent background color using the colorscheme
  - `borderColor = "${colors.secondary}dd"`  
    ▶️ sets the border color of notifications
  - `textColor = "${colors.on_surface}dd"`  
    ▶️ sets the text color
  - `layer = "overlay"`  
    ▶️ places notifications on the overlay layer (above other windows)
  - `extraConfig = "max-history=50"`  
    ▶️ keeps up to 50 notifications in history

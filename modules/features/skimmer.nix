{ inputs, ... }: {
  flake.nixosModules.skimmer = { config, ... }: {
    imports = [ inputs.skimmer.nixosModules.default ];

    services.skimmer = {
      enable = true;
      verbose = 1;
      settings = {
        output = "/home/wallago/sync-notes/skimmer/";
        miniflux = {
          url = "https://${config.preferences.miniflux.url}";
          username = "admin";
          password_file = config.sops.secrets."miniflux-admin-password".path;
        };
        claude = {
          model = "claude-haiku-4-5";
          api_key_file = config.sops.secrets."claude-api-key".path;
        };
        topic = {
          rust = {
            question = "What's going on interesting in the Rust world the past day?";
            feeds = [
              "Reddit Rust"
              "This Week in Rust"
            ];
            interval = "24h";
          };
          nix = {
            question = "What's new or noteworthy in the Nix/NixOS ecosystem the past day?";
            feeds = [
              "NixOS Discourse"
              "Reddit NixOS"
            ];
            interval = "24h";
          };
          neovim = {
            question = "Any new Neovim releases, plugins or config tricks worth knowing from the past day?";
            feeds = [
              "Neovim News"
              "Reddit Neovim"
            ];
            interval = "24h";
          };
          terminal = {
            question = "What new CLI/TUI tools or terminal workflows came up the past day?";
            feeds = [
              "Reddit CLI"
              "Reddit TUI"
            ];
            interval = "24h";
          };
          linux = {
            question = "What happened in the Linux kernel, distros and desktop stack the past day?";
            feeds = [
              "LWN"
              "Phoronix"
              "Reddit Linux"
            ];
            interval = "24h";
          };
          tech = {
            question = "What were the most discussed tech stories and trending repositories the past day?";
            feeds = [
              "Hacker News"
              "Github Trend"
            ];
            interval = "24h";
          };
          security = {
            question = "What notable vulnerabilities, breaches or security research came out the past week?";
            feeds = [
              "Schneier on Security"
              "Krebs on Security"
              "Port Swigger"
              "Project Zero"
            ];
            interval = "168h";
          };
          infra = {
            question = "What's interesting in infrastructure, DevOps and self-hosting the past week?";
            feeds = [
              "Cloudflare Blog"
              "Reddit Devops"
              "Reddit Self Hosted"
            ];
            interval = "168h";
          };
          blogs = {
            question = "Which in-depth programming or hardware articles from the past week are worth reading?";
            feeds = [
              "Drew DeVault"
              "Julia Evans"
              "Bunnie's blog"
              "Hackaday"
              "Reddit Programming"
            ];
            interval = "168h";
          };
          cycling = {
            question = "What happened in pro cycling the past week?";
            feeds = [ "Velo News" ];
            interval = "168h";
          };
          videos = {
            question = "Which new tech videos from the past day are worth watching, and what does each one cover?";
            feeds = [
              "Youtube Vimjoyer"
              "Youtube DevOps Toolbox"
            ];
            interval = "24h";
          };
        };
      };
    };
  };
}

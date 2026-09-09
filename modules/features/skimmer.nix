{ inputs, ... }: {
  flake.nixosModules.skimmer = { config, ... }: {
    imports = [ inputs.skimmer.nixosModules.default ];

    services.skimmer = {
      enable = true;
      settings = {
        output = "/home/wallago/sync-notes/skimmer/";
        miniflux = {
          url = config.preferences.miniflux.url;
          user = "admin";
          password_file = config.sops.secrets."miniflux-credentials".path;
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
        };
      };
    };
  };
}

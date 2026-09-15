{
  flake.nixosModules.atuinServer =
    let
      port = 51488;
    in
    {
      services.atuin = {
        enable = true;
        inherit port;
        maxHistoryLength = 8192;
        openRegistration = true;
      };
    };

  flake.nixosModules.atuinClient = {
    programs.atuin = {
      enable = true;
      settings = {
        auto_sync = true;
        sync_frequency = "5m";
        sync_address = "https://atuin.wallago.xyz";
        search_mode = "fuzzy";
        filter_mode = "global";
      };
    };
  };
}

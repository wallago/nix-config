{
  flake.nixosModules.nixCore = {
    nix = {
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
      optimise.automatic = true;
      settings = {
        trusted-users = [
          "root"
          "@wheel"
        ];
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        connect-timeout = 5;
        extra-substituters = [
          "https://cache.nixos.org"
          "https://nix-community.cachix.org"
          "https://nix-gaming.cachix.org"
          "https://cache.wallago.xyz/mycache"
          "https://claude-code.cachix.org"
        ];
        extra-trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
          "mycache:nsIUEPic0Apzfl+dUwiAcU9e8r2/maPx50IjfyHkRPg="
          "claude-code.cachix.org-1:YeXf2aNu7UTX8Vwrze0za1WEDS+4DuI2kVeWEE4fsRk="
        ];
      };
    };

    system.stateVersion = "26.11";

    nixpkgs.config.allowUnfree = true;
  };
}

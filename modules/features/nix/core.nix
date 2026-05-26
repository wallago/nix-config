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
      };
    };

    system.stateVersion = "26.05";

    nixpkgs.config.allowUnfree = true;
  };
}

{
  description = "My NixOS configuration";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nix-gaming.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
    connect-timeout = 5;
  };

  inputs = {
    # core
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    systems.url = "github:nix-systems/default-linux";
    impermanence.url = "github:nix-community/impermanence";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gl = {
      url = "github:nix-community/nixgl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # feat
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    themes.url = "github:wallago/nix-themes?dir=nix";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-bootstrap.url = "github:wallago/nix-bootstrap?dir=nix";
    nix-deployer.url = "github:wallago/nix-deployer?dir=nix";
    project-banner.url = "github:wallago/project-banner?dir=nix";

    # project
    rewind-backend.url = "git+ssh://git@github.com/wallago/rewind?dir=back/nix";
    rewind-frontend.url = "git+ssh://git@github.com/wallago/rewind?dir=front/nix";
    markeeper-backend.url = "git+ssh://git@github.com/wallago/markeeper?dir=back/nix";
    markeeper-frontend.url = "git+ssh://git@github.com/wallago/markeeper?dir=front/nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      systems,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      # Creates a lib var combining nixpkgs.lib with home-manager.lib
      lib = nixpkgs.lib // home-manager.lib;

      # For each system, the Nixpkgs for that system and sets the configuration to allow unfree packages
      forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs (import systems) (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );
    in
    {
      inherit lib;
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home;
      nixosAndHomeManagerModules = import ./modules/nixos-home;
      overlays = import ./overlays { inherit inputs; };
      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs inputs; });
      hydraJobs = import ./hydra.nix { inherit inputs outputs; };

      # NixOS system configuration
      nixosConfigurations =
        # Minimal config for each systems
        lib.listToAttrs (
          map (system: {
            name = "plankton-${system}";
            value = lib.nixosSystem {
              inherit system;
              modules = [ ./hosts/plankton ];
              specialArgs = { inherit inputs outputs; };
            };
          }) (import systems)
        )
        // {
          # Main desktop
          sponge = lib.nixosSystem {
            modules = [ ./hosts/sponge ];
            system = "x86_64-linux";
            specialArgs = { inherit inputs outputs; };
          };
          # Main laptop
          squid = lib.nixosSystem {
            modules = [ ./hosts/squid ];
            system = "x86_64-linux";
            specialArgs = { inherit inputs outputs; };
          };
          # Home server
          coral = lib.nixosSystem {
            modules = [ ./hosts/coral ];
            system = "x86_64-linux";
            specialArgs = { inherit inputs outputs; };
          };
          # Work server
          cuttlefish = lib.nixosSystem {
            modules = [ ./hosts/cuttlefish ];
            system = "x86_64-linux";
            specialArgs = { inherit inputs outputs; };
          };
        };

      # Standalone Home Manager only
      homeConfigurations = {
        # Main desktop
        "wallago@sponge" = lib.homeManagerConfiguration {
          modules = [
            ./home/users/wallago/sponge.nix
            ./home/nixpkgs.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        # Main laptop
        "wallago@squid" = lib.homeManagerConfiguration {
          modules = [
            ./home/users/wallago/squid.nix
            ./home/nixpkgs.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}

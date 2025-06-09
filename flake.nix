{
  description = "My NixOS configuration";

  nixConfig = {
    bash-prompt = "[nixos-raspberrypi-demo] ➜ ";
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nixos-raspberrypi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
    ];
    connect-timeout = 5;
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
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
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    themes = {
      url = "github:wallago/nix-themes";
      inputs.systems.follows = "systems";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
  };

  outputs = { self, nixpkgs, home-manager, systems, ... }@inputs:
    let
      inherit (self) outputs;
      # Creates a lib var combining nixpkgs.lib with home-manager.lib
      lib = nixpkgs.lib // home-manager.lib;

      # For each system, the Nixpkgs for that system and sets the configuration to allow unfree packages
      forEachSystem = f:
        lib.genAttrs (import systems) (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs (import systems) (system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        });
    in {
      inherit lib;
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home;
      overlays = import ./overlays { inherit inputs; };
      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
      hydraJobs = import ./hydra.nix { inherit inputs outputs; };

      # NixOS system configuration
      nixosConfigurations =
        # Minimal config for each systems
        lib.listToAttrs (map (system: {
          name = "plankton-${system}";
          value = lib.nixosSystem {
            inherit system;
            modules = [ ./hosts/plankton ];
            specialArgs = { inherit inputs outputs; };
          };
        }) (import systems)) // {
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
          # VPS
          octopus = lib.nixosSystem {
            modules = [ ./hosts/octopus ];
            system = "x86_64-linux";
            specialArgs = { inherit inputs outputs; };
          };
          # RPI5
          rpi5 = inputs.nixos-raspberrypi.lib.nixosSystem {
            modules = [ ./hosts/rpi5 ];
            specialArgs = inputs;
          };
        };

      # Home Manager system configuration
      homeConfigurations = {
        # Main desktop
        "wallago@sponge" = lib.homeManagerConfiguration {
          modules = [ ./home/users/wallago/sponge.nix ./home/nixpkgs.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        # Main laptop
        "wallago@squid" = lib.homeManagerConfiguration {
          modules = [ ./home/users/wallago/squid.nix ./home/nixpkgs.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        # VPS
        "wallago@octopus" = lib.homeManagerConfiguration {
          modules = [ ./home/users/wallago/octopus.nix ./home/nixpkgs.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}

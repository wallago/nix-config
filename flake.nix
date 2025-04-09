{
  description = "My NixOS configuration";

  inputs = {
    # ----- Core Nix Ecosystem -----
    # Primary package collection (unstable channel)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Stable package collection for critical components
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # Standard system architectures for cross-compilation
    systems.url = "github:nix-systems/default-linux";

    # ----- System Components -----
    # Hardware-specific configurations
    # hardware.url = "github:nixos/nixos-hardware";

    # Ephemeral storage management
    # impermanence.url = "github:nix-community/impermanence";

    # Color scheme management
    # nix-colors.url = "github:misterio77/nix-colors";

    # ----- User Environment Management -----
    # Home Manager for user-level configurations
    home-manager = {
      url = "github:nix-community/home-manager";
      # Align with our primary nixpkgs version
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ----- Security -----
    # Secrets management with SOPS
    # sops-nix = {
    #   url = "github:mic92/sops-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # ----- Storage Management -----
    # Declarative disk partitioning
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ----- Third-Party Packages -----
    # Firefox extensions repository
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Rust overlay for better management
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ----- Own Packages -----
    # Themes
    themes = {
      url = "github:YvesCousteau/nix-themes";
      inputs.systems.follows = "systems";
    };
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

      # Specifies a code formatter for each system architecture
      formatter = forEachSystem (pkgs: pkgs.alejandra);

      # Overlay is a mechanism to modify or extend the Nix package set
      overlays = import ./overlays { inherit inputs outputs; };

      # hydraJobs = import ./hydra.nix { inherit inputs outputs; };
      # packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
      # devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });

      # NixOS system configuration
      nixosConfigurations = {
        # Main desktop
        shusui = lib.nixosSystem {
          modules = [
            ./hosts/shusui
          ];
          specialArgs = {
            inherit inputs outputs;
          };
        };
      };

      # Home Manager system configuration
      homeConfigurations = {
        # Main desktop
        "yc@shusui" = lib.homeManagerConfiguration {
          modules = [
            ./users/yc/shusui.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
        };
      };
    };
}

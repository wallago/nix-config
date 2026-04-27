{
  description = "Welcome in how i see Nixos";

  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://cache.wallago.xyz"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "wallago:zWInaWbUegbCx5vbDctCdq/3GiYV3UbMNnqcLpTbGOM="
    ];
    netrc-file = "/etc/nix/netrc";
    connect-timeout = 5;
  };

  inputs = {
    # ─── Core ──────────────────────────────────────────────────────────────────

    # Nixpkgs — small unstable channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Modular flake authoring — split outputs into composable modules
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Auto-import a directory tree of Nix files as a single attrset
    import-tree.url = "github:vic/import-tree";

    # A Nix library to create wrapped executables via the module system
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    # Declarative ephemeral root: pick what survives a reboot
    impermanence.url = "github:nix-community/impermanence";

    # Per-user environment management on top of Nix
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Declarative secret management for NixOS, powered by sops
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Declarative disk partitioning and formatting
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secure Boot support for NixOS (UKI + signed kernels)
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Run unpatched binaries on Nix/NixOS
    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-index-database.follows = "nix-index-database";
    };

    # Weekly updated nix-index database
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ─── Features ──────────────────────────────────────────────────────────────

    # Community-driven Nix Flake for the Zen browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Soothing pastel theme for Nix
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Modules and schemes to make theming with Nix awesome
    nix-colors = {
      url = "github:misterio77/nix-colors";
      inputs.nixpkgs-lib.follows = "flake-parts/nixpkgs-lib";
    };

    # Curated Firefox add-ons exposed as Nix packages
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Breaking-news ticker / notifier
    eilmeldung = {
      url = "github:christo-auer/eilmeldung";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS MicroVMs
    microvm = {
      url = "github:microvm-nix/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS profiles for servers
    srvos = {
      url = "github:nix-community/srvos";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Yet another Discord mod
    moonlight = {
      url = "github:moonlight-mod/moonlight";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ─── Personal flakes ───────────────────────────────────────────────────────

    themes.url = "github:wallago/nix-themes?dir=nix";
    nix-bootstrap.url = "github:wallago/nix-bootstrap?dir=nix";
    nix-deployer.url = "github:wallago/nix-deployer?dir=nix";
    project-banner.url = "github:wallago/project-banner?dir=nix";

    # ─── Projects ──────────────────────────────────────────────────────────────

    rewind-backend.url = "git+ssh://git@github.com/wallago/rewind?dir=back/nix";
    rewind-frontend.url = "git+ssh://git@github.com/wallago/rewind?dir=front/nix";
    markeeper-backend.url = "git+ssh://git@github.com/wallago/markeeper?dir=back/nix";
    markeeper-frontend.url = "git+ssh://git@github.com/wallago/markeeper?dir=front/nix";
    gateway.url = "git+ssh://git@github.com/tools-hood/gateway?dir=nix";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}

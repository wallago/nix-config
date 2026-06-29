{
  description = "Welcome in how i see Nixos";

  inputs = {
    # ─── Core ──────────────────────────────────────────────────────────────────

    # Nixpkgs — small unstable channel
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Modular flake authoring — split outputs into composable modules
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Auto-import a directory tree of Nix files as a single attrset
    import-tree.url = "github:vic/import-tree";

    # ─── System ────────────────────────────────────────────────────────────────

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

    # Weekly updated nix-index database
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ─── Desktop ───────────────────────────────────────────────────────────────

    # Scrollable-tiling Wayland compositor
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Niri feature
    niri-float-sticky = {
      url = "github:probeldev/niri-float-sticky";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # A beautiful, minimal desktop shell for Wayland
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    # Curated Firefox add-ons exposed as Nix packages
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Lockscreen themes
    qylock = {
      url = "github:LordHerdier/qylock";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ─── Productivity ──────────────────────────────────────────────────────────

    # Breaking-news ticker / notifier
    eilmeldung = {
      url = "github:christo-auer/eilmeldung";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ─── Tooling ───────────────────────────────────────────────────────────────

    # Claude AI agent
    claude-code = {
      url = "github:sadjow/claude-code-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jj-starship = {
      url = "github:dmmulroy/jj-starship";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bp-to-bagels-csv = {
      url = "github:wallago/bp-to-bagels-csv";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Generate network/infra diagrams from the NixOS configs
    nix-topology = {
      url = "github:oddlama/nix-topology";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}

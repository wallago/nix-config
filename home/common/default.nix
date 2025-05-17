{ username, config, outputs, inputs, ... }: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ./colorscheme.nix
    ../feat/nvim
    ../feat/cli
    (import ./home.nix { inherit username config; })
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  # ---

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  systemd.user.startServices = "sd-switch";
}

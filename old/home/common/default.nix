{
  username,
  config,
  outputs,
  ...
}:
{
  imports = [
    ./colorscheme.nix
    ../feat/nvim
    ../feat/cli
    ../../yubikey
    (import ./home.nix { inherit username config; })
  ]
  ++ (builtins.attrValues outputs.homeManagerModules)
  ++ (builtins.attrValues outputs.nixosAndHomeManagerModules);

  # ---

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  systemd.user.startServices = "sd-switch";
}

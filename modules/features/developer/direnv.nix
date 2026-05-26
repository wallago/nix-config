{
  flake.nixosModules.direnv = {
    programs.direnv = {
      enable = true;
      silent = false;
      loadInNixShell = true;
      nix-direnv = {
        enable = true;
      };
      settings = {
        global = {
          hide_env_diff = true;
          warn_timeout = "1m";
        };
      };
    };
  };
}

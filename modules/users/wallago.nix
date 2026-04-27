{
  flake.homeModules.userWallago =
    { pkgs, ... }:
    {
      programs.bash.enable = true;
      programs.bash.shellAliases.ll = "ls -l";

      home.packages = [ pkgs.hello ];
      home.stateVersion = "24.11";
    };
}

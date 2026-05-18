{
  flake.homeModules.starship =
    { pkgs, ... }:
    {
      programs.starship = {
        enable = true;
        enableFishIntegration = true;
        extraPackages = [ pkgs.jj-starship ];

        settings = {
          git_branch.disabled = true;
          git_status.disabled = true;
          custom.jj = {
            when = "jj-starship detect";
            shell = [ "jj-starship" ];
            format = "$output ";
          };
        };
      };
    };
}

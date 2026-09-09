{
  flake.homeModules.starship =
    { pkgs, ... }:
    {
      # programs.starship = {
      #   enable = true;
      #   enableFishIntegration = true;
      #   extraPackages = [ pkgs.jj-starship ];
      #
      #   settings = {
      #     git_branch.disabled = true;
      #     git_status.disabled = true;
      #     custom.jj = {
      #       when = "jj-starship detect";
      #       shell = [ "jj-starship" ];
      #       format = "$output ";
      #     };
      #   };
      # };
      programs.starship = {
        enable = true;
        enableFishIntegration = true;
        extraPackages = [ pkgs.jj-starship ];

        settings = {
          format = "$directory$git_commit$custom$line_break$all$line_break$character";
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

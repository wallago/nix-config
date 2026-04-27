{ inputs, ... }:
{
  flake.homeModules.discord =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.discord.override {
          withOpenASAR = true;
          enableAutoscroll = true;
          withMoonlight = true;
          moonlight = inputs.moonlight.packages.${pkgs.system}.default;
        })
      ];
    };
}

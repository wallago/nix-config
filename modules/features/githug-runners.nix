{ self, ... }:
{
  flake.nixosModules.githubRunners =
    {
      config,
      lib,
      hostName,
      ...
    }:
    let
      cfg = config.preferences.github.runners;
      hostModule = self.nixosModules."preferencesGithubRunners${self.lib.capitalize hostName}";
    in
    {
      imports = [
        self.nixosModules.githubRunnersOptions
        hostModule
      ];

      services.github-runners = lib.mapAttrs (_: runner: {
        enable = true;
        inherit (runner) name tokenFile url;
      }) cfg;
    };
}

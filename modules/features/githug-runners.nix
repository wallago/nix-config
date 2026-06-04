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

      services.github-runners = lib.mapAttrs (name: runner: {
        enable = true;
        inherit name;
        inherit (runner) tokenFile url;
      }) cfg;
    };
}

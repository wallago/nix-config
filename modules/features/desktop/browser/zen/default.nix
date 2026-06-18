{ inputs, self, ... }:
{
  flake.homeModules.zen = {
    imports = [
      inputs.zen-browser.homeModules.beta
      self.homeModules.zenProfiles
      self.homeModules.zenPolicies
      self.homeModules.zenMods
      self.homeModules.zenExtensions
      self.homeModules.zenSearch
      self.homeModules.zenContainers
      self.homeModules.zenShortcuts
      self.homeModules.zenSpaces
      self.homeModules.zenPins
    ];

    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;
    };
  };
}

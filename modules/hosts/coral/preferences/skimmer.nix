{
  flake.nixosModules.preferencesSkimmerCoral = {
    preferences.skimmer = {
      server = {
        port = 5505;
        address = "0.0.0.0";
      };
      firewallInterfaces = [ "wg0" ];
    };
  };
}

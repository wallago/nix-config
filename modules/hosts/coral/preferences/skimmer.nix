{
  flake.nixosModules.preferencesSkimmerCoral = {
    preferences.skimmer = {
      server.port = 5505;
      firewallInterfaces = [ "wg0" ];
    };
  };
}

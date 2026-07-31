{
  flake.lib.ssh.hosts = {
    coral = {
      user = "wallago";
      port = 2222;
    };
    squid = {
      user = "wallago";
      port = 2222;
    };
    sponge = {
      user = "wallago";
      port = 2222;
    };
    cuttlefish = {
      user = "wallago";
      port = 2222;
    };
    krill = {
      user = "wallago";
      port = 2222;
    };
    worm = {
      user = "wallago";
      port = 2222;
    };
    anemone = {
      user = "wallago";
      port = 2222;
    };
    provision-iso = {
      user = "root";
      port = 2222;
    };
    "4849" = [
      {
        alias = "4849-router";
        user = "root";
        port = 22;
      }
      {
        alias = "4849-griffon";
        user = "labcar";
        port = 2201;
      }
    ];
    "4837" = [
      {
        alias = "4837-router";
        user = "root";
        port = 22;
      }
    ];
  };
}

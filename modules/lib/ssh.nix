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
        alias = "4849-griffon";
        user = "labcar";
        port = 2201;
      }
    ];
    "4837" = [
      {
        alias = "4837-gordini";
        user = "gordini";
        port = 2201;
      }
    ];
    "4842" = [
      {
        alias = "4842-n1";
        user = "n1";
        port = 2201;
      }
      {
        alias = "4842-n2";
        user = "n2";
        port = 2202;
      }
      {
        alias = "4842-n3";
        user = "n3";
        port = 2203;
      }
    ];
  };
}

{
  flake.homeModules.idle = {
    # Lock with the same command as Mod+Escape after 5 minutes without input
    services.swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 300;
          command = "qylock-lock";
        }
      ];
    };
  };
}

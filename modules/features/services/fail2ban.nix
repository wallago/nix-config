{
  flake.nixosModules.fail2ban = {
    services.fail2ban = {
      enable = true;
      maxretry = 5;
      bantime = "1h";
      findtime = "10min";
      bantime-increment = {
        enable = true;
        multipliers = "1 2 4 8 16 32 64";
        maxtime = "168h"; # 1 week cap
      };
    };
  };
}

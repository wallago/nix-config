{ self, ... }: {
  flake.homeModules.sshWg0 =
    { lib, ... }:
    let
      inherit (self.lib.networks) wg0;
      port = 2222;
      user = "wallago";
      headless = [
        "coral"
        "cuttlefish"
        "krill"
        "anemone"
      ];
      mkHost =
        name: host:
        {
          hostname = host.ip;
          inherit port user;
        }
        // lib.optionalAttrs (lib.elem name headless) {
          setEnv = "TERM=xterm-256color";
        };
    in
    {
      programs.ssh.settings = lib.mapAttrs mkHost wg0.hosts;
    };
}

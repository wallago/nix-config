{ pkgs, mkScript, ... }: {
  interval = 1;
  exec-if = mkScript {
    deps = [ pkgs.util-linux ];
    script = "rfkill | grep '<blocked>'";
  };
}

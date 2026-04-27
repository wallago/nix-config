{ mkScript, ... }: {
  exec = mkScript {
    script = ''
      echo "$USER@$HOSTNAME"
    '';
  };
  on-click = mkScript {
    script = ''
      systemctl --user restart waybar
    '';
  };
}

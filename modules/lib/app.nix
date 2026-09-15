{
  flake.lib.app.command = { pkgs, lib }: {
    note = [
      "ghostty"
      "--class=com.slot.notes"
      "--title=notes"
      "--working-directory=/home/wallago/sync-notes/"
      "-e"
      "vi"
    ];
    todo = [
      "ghostty"
      "--class=com.slot.todo"
      "--title=todo"
      "--working-directory=/home/wallago/sync-pm/"
      "-e"
      "vi"
      "gateway.md"
    ];
    mail = [
      "ghostty"
      "--class=com.slot.mail"
      "--title=matcha"
      "-e"
      "matcha"
    ];
    webSecondary = [
      "zen-beta"
      "--name=zen.static"
      "--new-instance"
      "https://twitch.com"
    ];
    webMain = [
      "zen-beta"
      "--name=com.slot.zen.main"
      "--new-instance"
    ];
    monitor = [
      "ghostty"
      "--title=monitor"
      "-e"
      "vi"
    ];
    expenseTracker = [
      "ghostty"
      "--title=bagels"
      "-e"
      "bagels"
    ];
    resources = [
      "ghostty"
      "--class=com.slot.resources"
      "--title=resources"
      "-e"
      "${lib.getExe pkgs.bottom}"
    ];
    term = [
      "ghostty"
      "--class=com.slot.term"
      "--title=term"
    ];
  };
}

{ inputs, pkgs, ... }: {
  programs.git = {
    userName = "YvesCousteau";
    userEmail = "45556867+YvesCousteau@users.noreply.github.com";
  };

  programs.firefox.profiles.yc = {
    extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
      ublock-origin # ----> Content blocker
      browserpass # ------> Password manager
      vimium # -----------> Keyboard shortcuts
      privacy-badger # ---> Block invisible trackers
      new-tab-override # -> Set the page that shows whenever you open a new tab
    ];
  };
}

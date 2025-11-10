{ pkgs, ... }: {
  services.flatpak.enable = true;
  systemd.services.flatpak-bambu-studio = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      flatpak install flathub com.bambulab.BambuStudio
    '';
  };

  programs.fish.shellAliases = {
    "bambu-studio" = "flatpak run com.bambulab.BambuStudio";
  };
}

{ self, ... }:
{
  flake.nixosModules.devApps = {
    imports = [
      # self.nixosModules.bambulab
      self.nixosModules.kicad
      self.nixosModules.rustdesk
    ];

    # flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    # flatpak install flathub com.bambulab.BambuStudio
    services.flatpak.enable = true;
  };
}

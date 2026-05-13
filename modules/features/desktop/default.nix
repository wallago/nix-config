{ self, ... }:
{
  flake.nixosModules.desktop = {
    imports = [
      self.nixosModules.displayManager
      self.nixosModules.fonts
      self.nixosModules.compositor
      self.nixosModules.desktopShell
      self.nixosModules.printer
    ];
  };

  flake.homeModules.desktop =
    { pkgs, ... }:
    {
      imports = [
        self.homeModules.desktopOptions
        self.homeModules.shell
        self.homeModules.compositor
        self.homeModules.browser
        self.homeModules.wallpaper
        self.homeModules.terminalEmulator
      ];

      home.packages = with pkgs; [
        wl-clipboard
      ];
    };

}

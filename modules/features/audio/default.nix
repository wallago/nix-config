{ self, ... }:
{
  flake.nixosModules.audio = {
    imports = [
      self.nixosModules.pipewire
      self.nixosModules.rtkit
      self.nixosModules.pulseaudio
    ];
  };
}

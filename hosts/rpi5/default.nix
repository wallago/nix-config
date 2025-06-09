{ inputs, pkgs, lib, config, ... }:
let
  hostname = "rpi5";
  kernelBundle = pkgs.linuxAndFirmware.v6_6_31;
in {
  imports = with inputs.nixos-raspberrypi.nixosModules;
    [
      # Hardware configuration
      raspberry-pi-5.base
      raspberry-pi-5.display-vc4
      ./hardware-configuration.nix
    ] ++ [ inputs.disko.nixosModules.disko ./disko-nvme-zfs.nix ];

  # ***

  time.timeZone = "UTC";
  networking.hostName = "rpi${config.boot.loader.raspberryPi.variant}-demo";

  services.udev.extraRules = ''
    # Ignore partitions with "Required Partition" GPT partition attribute
    # On our RPis this is firmware (/boot/firmware) partition
    ENV{ID_PART_ENTRY_SCHEME}=="gpt", \
      ENV{ID_PART_ENTRY_FLAGS}=="0x1", \
      ENV{UDISKS_IGNORE}="1"
  '';

  environment.systemPackages = with pkgs; [ tree ];

  users.users.nixos.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDeHeEEvLFm3QIt5rduQssQ9bytqZql5RY9ZBh1yLFGeSdjR9m2efIjPPxg1TG5wcmXfC8l3XEt6bCgtLnzXBdaiN0cqdwYKWJzU+R8pYqb+/WsD03Cjk2b2OG6UhJaJ1gUdbaiGDDOYTWryEn33nxeabUP8KxCoC0g0H0Aa4VnLltNqS0SPxQMStjXG8xr7oR9CwOUF0cGaQbhn8qmRFALSeDieCgVgzazI9PWzGQEuWx6XgpocXb5aeVVVzkO2FW5I8Rzp/rseu1YQ8R5MSbWekx02LQw+lU0kdNFtxBiB1prpUa104RR+vUL/w7c0FeFTb+SUwJ6rddOj66do8eh openpgp:0xD204CD2B"

  ];
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDeHeEEvLFm3QIt5rduQssQ9bytqZql5RY9ZBh1yLFGeSdjR9m2efIjPPxg1TG5wcmXfC8l3XEt6bCgtLnzXBdaiN0cqdwYKWJzU+R8pYqb+/WsD03Cjk2b2OG6UhJaJ1gUdbaiGDDOYTWryEn33nxeabUP8KxCoC0g0H0Aa4VnLltNqS0SPxQMStjXG8xr7oR9CwOUF0cGaQbhn8qmRFALSeDieCgVgzazI9PWzGQEuWx6XgpocXb5aeVVVzkO2FW5I8Rzp/rseu1YQ8R5MSbWekx02LQw+lU0kdNFtxBiB1prpUa104RR+vUL/w7c0FeFTb+SUwJ6rddOj66do8eh openpgp:0xD204CD2B"
  ];

  system.nixos.tags = let cfg = config.boot.loader.raspberryPi;
  in [
    "raspberry-pi-${cfg.variant}"
    cfg.bootloader
    config.boot.kernelPackages.kernel.version
  ];

  # ***

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
    # Allow the graphical user to login without password
    initialHashedPassword = "";
  };

  # Allow the user to log in as root without a password.
  users.users.root.initialHashedPassword = "";

  # Don't require sudo/root to `reboot` or `poweroff`.
  security.polkit.enable = true;

  # Allow passwordless sudo from nixos user
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  # Automatically log in at the virtual consoles.
  services.getty.autologinUser = "nixos";

  # We run sshd by default. Login is only possible after adding a
  # password via "passwd" or by adding a ssh key to ~/.ssh/authorized_keys.
  # The latter one is particular useful if keys are manually added to
  # installation device for head-less systems i.e. arm boards by manually
  # mounting the storage in a different system.
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  # allow nix-copy to live system
  nix.settings.trusted-users = [ "nixos" ];

  # We are stateless, so just default to latest.
  system.stateVersion = config.system.nixos.release;

  # ***

  # This is mostly portions of safe network configuration defaults that
  # nixos-images and srvos provide

  networking.useNetworkd = true;
  # mdns
  networking.firewall.allowedUDPPorts = [ 5353 ];
  systemd.network.networks = {
    "99-ethernet-default-dhcp".networkConfig.MulticastDNS = "yes";
    "99-wireless-client-dhcp".networkConfig.MulticastDNS = "yes";
  };

  # This comment was lifted from `srvos`
  # Do not take down the network for too long when upgrading,
  # This also prevents failures of services that are restarted instead of stopped.
  # It will use `systemctl restart` rather than stopping it with `systemctl stop`
  # followed by a delayed `systemctl start`.
  systemd.services = {
    systemd-networkd.stopIfChanged = false;
    # Services that are only restarted might be not able to resolve when resolved is stopped before
    systemd-resolved.stopIfChanged = false;
  };

  # Use iwd instead of wpa_supplicant. It has a user friendly CLI
  networking.wireless.enable = false;
  networking.wireless.iwd = {
    enable = true;
    settings = {
      Network = {
        EnableIPv6 = true;
        RoutePriorityOffset = 300;
      };
      Settings.AutoConnect = true;
    };
  };

  # ***

  networking.hostId = "8821e309";
  boot.tmp.useTmpfs = true;

  boot = {
    loader.raspberryPi.firmwarePackage = kernelBundle.raspberrypifw;
    kernelPackages = kernelBundle.linuxPackages_rpi5;
  };

  nixpkgs.overlays = lib.mkAfter [
    (self: super: {
      # This is used in (modulesPath + "/hardware/all-firmware.nix") when at least 
      # enableRedistributableFirmware is enabled
      # I know no easier way to override this package
      inherit (kernelBundle) raspberrypiWirelessFirmware;
      # Some derivations want to use it as an input,
      # e.g. raspberrypi-dtbs, omxplayer, sd-image-* modules
      inherit (kernelBundle) raspberrypifw;
    })
  ];
}

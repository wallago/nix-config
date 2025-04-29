{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ rust-bin.nightly.latest.complete ];
}

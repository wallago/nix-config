{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    anydesk
    rustdesk
  ];
}

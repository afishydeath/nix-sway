{ host, pkgs, ... }:
{
  networking = {
    hostName = host.name;
    networkmanager.enable = true;
  };

  # Localisation
  time.timeZone = "Australia/Sydney";
  i18n.defaultLocale = "en_AU.UTF-8";
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  # ensure i never need nano
  environment.systemPackages = [ pkgs.helix ];

  # nix config
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "24.11"; # don't change
}

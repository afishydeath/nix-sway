{
  host,
  user,
  pkgs,
  ...
}:
{
  # Localisation
  time.timeZone = "Australia/Sydney";
  i18n.defaultLocale = "en_AU.UTF-8";

  # Networking
  networking = {
    hostName = host.name;
    networkmanager.enable = true;
  };

  users.users.${user.name} = {
    isNormalUser = true;
    description = "${user.name}";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
  };

  # hardware
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
  # services
  services = {
    # bluetooth
    blueman.enable = true;
    # audio
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
    pulseaudio.enable = true;
    # security
    gnome.gnome-keyring.enable = true;
    # greeter
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd sway";
        };
      };
    };
    xserver = {
      # keyboard
      xkb = {
        layout = "au";
        variant = "";
      };
    };
  };

  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
    };
  };

  environment.systemPackages = with pkgs; [
    # editor
    helix
    # for sway
    grim
    wl-clipboard
    mako
    # others
    btm
  ];

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
    rofi = {
      enable = true;
    };
    kitty = {
      enable = true;
    };
    waybar = {
      enable = true;
      settings = import ./waybar_conf.nix;
    };
    light.enable = true; # to change brightness
  };

  # nix config
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "24.11"; # don't change
}

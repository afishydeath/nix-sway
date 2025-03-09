{ user, ... }:
{
  programs = {
    home-manager.enable = true;
  };

  home = {
    username = user.name;
    homeDirectory = /home/${user.name};
    stateVersion = "24.11";
  };

  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "kitty";
    };
  };
}

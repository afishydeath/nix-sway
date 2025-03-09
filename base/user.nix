{ uname, ... }:
{
  programs = {
    home-manager.enable = true;
  };

  home = {
    username = uname;
    homeDirectory = /home/${uname};
    stateVersion = "24.11";
  };
}

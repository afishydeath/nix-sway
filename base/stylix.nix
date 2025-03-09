{ user, ... }:
{
  stylix = {
    enable = true;
    inherit (user.stylix) image base16Scheme;
  };
}

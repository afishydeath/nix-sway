{
  description = "My new from scratch config for i3";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      stylix,
      ...
    }@inputs:
    let
      pkgs = nixpkgs;
      host = {
        system = "x86_64-linux";
        hname = "chonk";
      };
      user = {
        uname = "syn";
        email = "afishydeath@gmail.com";
        stylix.image = ./wallpapers/monokai.png;
        stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/monokai.yaml";
      };
    in
    {
      nixosConfigurations = {
        "${host.hname}" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit (host) system;
            inherit inputs;
            inherit (user) uname;
            inherit host;
          };
          modules = [
            ./base/host.nix
            ./hosts/${host.name}
            inputs.stylix.nixosModules.stylix
          ];
        };
      };
      homeConfigurations = {
        "${user.uname}" = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit (user) uname;
            inherit inputs;
            inherit (host) hname;
          };
          modules = [
            inputs.stylix.homeManagerModules.stylix
            ./base/user.nix
            ./users/${user.uname}
          ];
        };
      };
    };
}

{
  description = "Maximal nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    # TODO: get this from a local config file
    userinfo = {
      username = "frodo";            # <---- Change this to your main/admin/interactive username
      fullname = "Frodo Baggins";
      email = "frodo@bagend.shire";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#bootstrap
    # "bootstrap" can be changed to match your hostname, or better just use this flake to bootstrap
    # your system and then rebuild Nix Darwin using your separate custom flake.nix file.
    darwinConfigurations."bootstrap" = nix-darwin.lib.darwinSystem {
      modules = [
        home-manager.darwinModules.home-manager
        ./darwin/core-darwin-config.nix
        ./darwin/git.nix
        ./darwin/system-packages.nix
      ];
      specialArgs = { inherit inputs userinfo; };
    };
  };
}

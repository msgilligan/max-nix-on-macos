{
  description = "Maximal nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    userinfo = {
      username = "frodo";            # <---- Change this to your main/admin/interactive username
      fullname = "Frodo Baggins";
      email = "frodo@bagend.shire";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#max
    # "max" should be changed to match your hostname (or vice-versa if you want to name your host "max")
    darwinConfigurations."max" = nix-darwin.lib.darwinSystem {
      modules = [
        home-manager.darwinModules.home-manager
        ./darwin/core-darwin-config.nix
        ./darwin/system-packages.nix
        ./home/simple-home.nix
      ];
      specialArgs = { inherit inputs userinfo; };
    };
  };
}

{
  description = "Maximal nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    unused = true;
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#max
    # "max" should be changed to match your hostname (or vice-versa if you want to name your host "max")
    darwinConfigurations."max" = nix-darwin.lib.darwinSystem {
      modules = [
        ./darwin/core-darwin-config.nix
        ./darwin/system-packages.nix
      ];
      specialArgs = { inherit inputs; };
    };
  };
}

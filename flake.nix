{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-23.11";

    home-manager = {
       url = "github:nix-community/home-manager/release-23.11";
       inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:Tomaszal/nix-flatpak/feature/overrides";

    nixvim = {
      url = "github:nix-community/nixvim/nixos-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {

      homeManagerModules.snowpenguin = ./modules/home-manager/snowpenguin.nix;
    
      nixosConfigurations.snowpenguin = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [ 
            ./hosts/snowpenguin/configuration.nix
            ./hosts/snowpenguin/hardware-configuration.nix
            ./modules/nixos/flatpak.nix
            ./modules/nixos/hardening.nix
            inputs.nix-flatpak.nixosModules.nix-flatpak
            inputs.home-manager.nixosModules.default
          ];
        };

    };
}

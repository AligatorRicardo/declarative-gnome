{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";

    home-manager = {
       url = "github:nix-community/home-manager/release-24.11";
       inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/main";

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs @{ nixpkgs, self, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
    in
    {
      # Configuration for the Antioch setup
      homeManagerModules.antioch = ./modules/home-manager/antioch.nix; 
      nixosConfigurations.antioch = nixpkgs.lib.nixosSystem {
          specialArgs = {
	    inherit system; 
	    inherit inputs;
          };
          modules = [ 
	    {nixpkgs.overlays = [inputs.hyprpanel.overlay];}
            ./hosts/antioch/configuration.nix
            ./hosts/antioch/hardware-configuration.nix
            ./modules/nixos/apps/flatpak.nix
	    ./modules/nixos/system/nvidia.nix
	    ./modules/nixos/apps/steam.nix
            inputs.nix-flatpak.nixosModules.nix-flatpak
	    inputs.home-manager.nixosModules.default
          ];
      };

      # Configuration for the Alexandria setup (same as Antioch, but with GPU Passthrough support)
      homeManagerModules.alexandria = ./modules/home-manager/antioch.nix; 
      nixosConfigurations.alexandria = nixpkgs.lib.nixosSystem {
          specialArgs = {
	    inherit system; 
	    inherit inputs;
          };
          modules = [ 
	    {nixpkgs.overlays = [inputs.hyprpanel.overlay];}
            ./hosts/antioch/configuration.nix
            ./hosts/antioch/hardware-configuration.nix
            ./modules/nixos/apps/flatpak.nix
	    ./modules/nixos/system/gpupassthrough.nix
	    ./modules/nixos/apps/steam.nix
            inputs.nix-flatpak.nixosModules.nix-flatpak
	    inputs.home-manager.nixosModules.default
          ];
      };

    };
}

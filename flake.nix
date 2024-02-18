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

  outputs = { self, nixpkgs, nix-on-droid, ... }@ inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      extensions = inputs.nix-vscode-extensions.extensions.${system};
    in
    {

      # Configuration for the Snowpenguin setup
      homeManagerModules.snowpenguin = ./modules/home-manager/snowpenguin.nix; 
      nixosConfigurations.snowpenguin = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [ 
            ./hosts/snowpenguin/configuration.nix
            ./hosts/snowpenguin/hardware-configuration.nix
            ./modules/nixos/flatpak.nix
	    ./modules/nixos/nvidia.nix
            ./modules/nixos/hardening.nix
            ./modules/nixos/tlp.nix
	    ./modules/nixos/syncthing.nix
            inputs.nix-flatpak.nixosModules.nix-flatpak
	    inputs.home-manager.nixosModules.default
          ];
        };

      # Python devshell
      devShells.x86_64-linux.python = pkgs.mkShell {
           nativeBuildInputs = with pkgs; [
              python3
           ];

	   shellHook = ''
              echo "Welcome to my Python devshell"
           '';
      };

   };
}

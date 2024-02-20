{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-23.11";

    home-manager = {
       url = "github:nix-community/home-manager/release-23.11";
       inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/main";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    flake-utils.follows = "nix-vscode-extensions/flake-utils"; 

    nixvim = {
      url = "github:nix-community/nixvim/nixos-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccinifier = {
       url = "github:lighttigerXIV/catppuccinifier";
       inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, nix-vscode-extensions, catppuccinifier, ... }@ inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      extensions = inputs.nix-vscode-extensions.extensions.${system};
    in
    {

      # Configuration for the Snowpenguin setup
      homeManagerModules.snowpenguin = ./modules/home-manager/snowpenguin.nix; 
      nixosConfigurations.snowpenguin = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs nix-vscode-extensions catppuccinifier;};
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

      # Rust devshell
      devShells.x86_64-linux.rust = pkgs.mkShell {
           nativeBuildInputs = with pkgs; [
              rustc
	      rustup
           ];

	   shellHook = ''
              echo "Welcome to the Rust Devshell"
           '';

      };

   };
}

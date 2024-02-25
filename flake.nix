{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-23.11";

    home-manager = {
       url = "github:nix-community/home-manager/release-23.11";
       inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/main";

    nixvim = {
      url = "github:nix-community/nixvim/nixos-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccinifier = {
       url = "github:lighttigerXIV/catppuccinifier";
       inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, catppuccinifier, ... }@ inputs:
    let
      system = "x86_64-linux";
      #pkgs = nixpkgs.legacyPackages.${system};
      pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
    in
    {
      # Configuration for the Snowpenguin setup
      homeManagerModules.snowpenguin = ./modules/home-manager/snowpenguin.nix; 
      nixosConfigurations.snowpenguin = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs catppuccinifier;};
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

      # Fullstack devshell
      devShells.x86_64-linux.fullstack = pkgs.mkShell {
	   nativeBuildInputs = with pkgs; [
              # Node + Javascript
	      nodejs
	      electron_28
	      # Java
	      openjdk19
	      jetbrains.idea-community
           ];
           
           shellHook = ''
              echo "Welcome to the Fullstack Devshell"
           '';
      };


      # Android devshell
      devShells.x86_64-linux.android = pkgs.mkShell {
	   nativeBuildInputs = with pkgs; [
	      android-tools
	      android-studio
	      scrcpy
	      kotlin
           ];
           
	   shellHook = ''
               echo "Welcome to the Android Devshell"
           '';
      };
};
}

{
  description = "Personal configuration of NixOS, made with flakes.";

  inputs = {
    zen-browser.url = "github:omarcresp/zen-browser-flake";
    prismlauncher.url = "github:PrismLauncher/PrismLauncher";
    niri.url = "github:sodiboo/niri-flake";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      home-manager,
      nixpkgs,
      flake-parts,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } (
      top@{
        config,
        withSystem,
        moduleWithSystem,
        ...
      }:
      let
        systems = [
          "x86_64-linux"
          "aarch64-darwin"
        ];
        lib = inputs.nixpkgs.lib // inputs.home-manager.lib;
      in
      {
        imports = [
          # Optional: use external flake logic, e.g.
          # inputs.foo.flakeModules.default
          inputs.home-manager.flakeModules.home-manager
        ];
        flake = {
          # Put your original flake attributes here.
          formatter = nixpkgs.legacyPackages.x86_64-linux.alejandra;

          nixosConfigurations = {
            mjolnir = nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs; };
              modules = [ ./configuration.nix ];
            };
          };
          homeConfigurations = {
            mjolnir = lib.homeManagerConfiguration {
              pkgs = nixpkgs.legacyPackages.x86_64-linux;
              extraSpecialArgs = { inherit inputs; };
              modules = [ ./home.nix ];
            };
          };
        };
        inherit systems;
        perSystem =
          { config, pkgs, ... }:
          {
            # Recommended: move all package definitions here.
            # e.g. (assuming you have a nixpkgs input)
            # packages.foo = pkgs.callPackage ./foo/package.nix { };
            # packages.bar = pkgs.callPackage ./bar/package.nix {
            #   foo = config.packages.foo;
            # };
          };

      }
    );
}

{
  description = "Personal configuration of NixOS, made with flakes.";

  nixConfig = {
    allow-import-from-derivation = true;
    extra-experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operator"
    ];
  };
  inputs = {
    #Browsers
    firefox.url = "github:nix-community/flake-firefox-nightly";
    helium-flake.url = "github:oxcl/nix-flake-helium-browser";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #Nix Stuff
    #devshell.url = "github:numtide/devshell";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lix = {
      url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-26.05";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    #Terminal
    wezterm = {
      url = "github:wez/wezterm?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #Editor
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #Gaming
    prismlauncher.url = "github:PrismLauncher/PrismLauncher";
    #Wayland stuff (will eventually remove either Noctalia or DMS)
    mango = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-nix.url = "git+https://codeberg.org/BANanaD3V/niri-nix";
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
    #dms.url = "github:duxlabs-dev/dux-shell/stable";
  };

  outputs =
    {
      self,
      home-manager,
      nixpkgs,
      flake-parts,
      stable,
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
        lib = inputs.nixpkgs.lib // inputs.home-manager.lib;
        mkHost =
          hostname:
          nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            modules = [ ./hosts/${hostname} ];
          };
      in
      {
        systems = [
          "x86_64-linux"
          "aarch64-darwin"
        ];
        imports = [
          inputs.home-manager.flakeModules.home-manager
        ];
        flake = {
          # Put your original flake attributes here.

          nixosConfigurations = {
            trantor = mkHost "trantor";
            helicon = mkHost "helicon"; # TODO: fix for Desktop machine
          };
        };
        # inherit systems;
        #perSystem =
        #  { config, pkgs, ... }:
        #  {

        #  };
      }
    );
}

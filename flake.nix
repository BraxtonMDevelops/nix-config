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
    firefox.url = "github:nix-community/flake-firefox-nightly";
    devshell.url = "github:numtide/devshell";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
    };
    wezterm = {
      url = "github:wez/wezterm?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    prismlauncher.url = "github:PrismLauncher/PrismLauncher";
    noctalia.url = "github:noctalia-dev/noctalia-shell";
    niri.url = "github:sodiboo/niri-flake";
    #TODO: Use niri flake actually.
    nixos.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-26.05";
    niri.inputs.nixpkgs.follows = "stable";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lix = {
      url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
      flake = false;
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.lix.follows = "lix";
    };
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

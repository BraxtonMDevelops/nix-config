{
  config,
  lib,
  pkgs,
  home-manager,
  inputs,
  niri,
  ...
}: {
  imports = [
    "./desktop/niri.nix"
  ];
  home.username = "mjolnir";
  home.homeDirectory = "/home/mjolnir";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    eza
    tree
    bat
    zoxide
    libsForQt5.qtstyleplugin-kvantum
  ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPakcages = true;
  };
  programs.fish = {
    enable = true;
    interactiveShellInit = "set PATH ~/.config/emacs/bin $PATH";
    shellAliases = with pkgs; {
      ls = "eza --color=auto --icons";
      cat = "bat";
    };
  };
  home.pointerCursor = {
    dotIcons.enable = true;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.banana-cursor;
    name = "Banana Cursor";
    size = 64;
  };
  gtk.enable = true;
  gtk.cursorTheme = {
    name = "Banana Cursor";
    package = pkgs.banana-cursor;
  };
  programs.starship = {
    enable = true;
  };
}

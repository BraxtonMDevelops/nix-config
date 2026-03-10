{
  config,
  lib,
  pkgs,
  home-manager,
  inputs,
  ...
}:

{
  imports = [
    ./niri.nix 
    #./noctalia.nix # TODO Migrate noctalia config out of niri file and configure declaratively.
  ];
  home.username = "mjolnir";
  home.homeDirectory = "/home/mjolnir";
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    eza
    tree
    bat
    libsForQt5.qtstyleplugin-kvantum
  ];

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
    size = 48; # Test smaller cursor size for laptop
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

{
  config,
  lib,
  pkgs,
  home-manager,
  inputs,
  niri,
  ...
}:

{
  imports = [
  ];
  home.username = "mjolnir";
  home.homeDirectory = "/home/mjolnir";
  home.stateVersion = "22.11";
  home.packages = with pkgs; [
    eza
    tree
    bat
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
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.phinger-cursors;
    name = "phinger-cursors";
    size = 64;
  };
  programs.starship = {
    enable = true;
  };

}

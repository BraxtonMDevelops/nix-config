{
  pkgs,
  inputs,
  home-manager,
  lib,
  config,
  ...
}:
{

  home.packages = with pkgs; [
    alacritty
    mako
    swaybg
    swaylock
    swayidle
    xdg-desktop-portal-gnome
    gnome-keyring
    xwayland-satellite
  ];
}

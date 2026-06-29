{pkgs, lib, home-manager, config, ...}:

{
  home.packages = with pkgs; [ guile ];
}

# TODO Change location of this file.
# File for Gaming stuff. Will probably put this somewhere different eventually.
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
  environment.systemPackages = with pkgs; [
    # Different Launchers besides the STEAM
    lutris
    heroic
    protonplus
    inputs.paring.packages.x86_64-linux.xmcl
    # Setup different JDKs for Prism Launcher usage.
    (prismlauncher.override {
      jdks = [
        zulu
        zulu17
        zulu8
      ];
    })
  ];

}

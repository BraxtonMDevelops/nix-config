{
  pkgs,
  inputs,
  home-manager,
  lib,
  config,
  ...
}: {
  programs.noctalia.enable = true;

  programs.niri = {
    settings = {
      binds = {
        "Mod+T".action.spawn = ["ghostty"];
        "Mod+Space".action.spawn = ["noctalia-ipc" "launcher toggle"];
        "Mod+Shift+Slash".action.show-hotkey-overlay = [];
        "XF86AudioLowerVolume".action.spawn = ["noctalia-ipc" "call" "volume" "decrease"];
        "XF86AudioRaiseVolume".action.spawn = ["noctalia-ipc" "call" "volume" "increase"];
        "XF86AudioMute".action.spawn = ["noctalia-ipc" "call" "volume" "muteOutput"];
        "XF86MonBrightnessDown".action.spawn = ["noctalia-ipc" "call" "brightness" "decrease"];
        "XF86MonBrightnessUp".action.spawn = ["noctalia-ipc" "call" "brightness" "increase"];
      };
      spawn-at-startup = [
        {
          command = [
            "mako"
            "noctalia-shell"
          ];
        }
      ];
    };
  };
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

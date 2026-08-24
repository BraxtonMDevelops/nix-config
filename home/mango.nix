{
  pkgs,
  inputs,
  home-manager,
  lib,
  config,
  ...
}:
{
  wayland.WindowManager.mango.enable = true;
  # MangoWM and Niri configured via config files for when not on KDE
  # Currently on KDE, so window managers are not enabled
  # Config files exist for future use:
  # - ~/.config/niri/config.kdl - Niri KDL config (live-reloaded)
  # - MangoWM settings defined in mango.nix (not enabled while on KDE)

  # Noctalia still available as IPC framework

}

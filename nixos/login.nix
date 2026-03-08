{
  flake.modules.nixos.plasmaLogin =
    { pkgs }:
    {
      services.displayManger.plasma-login-manager = {
        package = pkgs.kdePackage.plasma-login-manager;
    };
  };
}

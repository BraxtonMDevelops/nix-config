{inputs, ...}: {
  imports = [
    inputs.home-manager.nixosModules.default #TODO: Refactor for usage on MacOS
  ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}

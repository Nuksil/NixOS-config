{
description = "My flake";

inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
};

outputs = { self, nixpkgs, ...}:
  let
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
        NukNix = lib.nixosSystem {
            system = "86_64-linux";
            modules = [ ./configuration.nix ];
        };
     };
  };
}

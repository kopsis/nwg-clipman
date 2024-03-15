{
  #inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = { self, nixpkgs, flake-utils, ... }:
    let
      out = system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          appliedOverlay = self.overlays.default pkgs pkgs;
        in
        {
          packages.nwg-clipman = appliedOverlay.nwg-clipman;
        };
    in
    flake-utils.lib.eachDefaultSystem out // { # update out with following attrset
      overlays.default = final: prev: {
        nwg-clipman = final.callPackage ./derivation.nix { };
      };
    };
}


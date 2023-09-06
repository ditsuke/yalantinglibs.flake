{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        name = "yalantinglibs";
        src = pkgs.fetchFromGitHub
          {
            owner = "alibaba";
            repo = "yalantinglibs";
            fetchSubmodules = true;
            rev = "3171bc57079a550462c035f320c6bb056d719886";
            sha256 = "sha256-PztJ5Yke6AG5KJtt2bolb9hn1gKXndBJSNzOD5/eGFE=";
          };
        buildInputs = with pkgs ; [ ];
        nativeBuildInputs = with pkgs; [
          cmake
        ];
      in
      {
        packages.default = pkgs.stdenv.mkDerivation
          {
            inherit name src buildInputs nativeBuildInputs;
          };
      }
    );
}

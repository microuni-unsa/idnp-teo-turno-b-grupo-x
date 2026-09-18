{
  description = "A flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
        fonts = with pkgs; [
          carlito
        ];
      in
      {
        devShells.default = pkgs.mkShell {
          LD_LIBRARY_PATH =
            with pkgs;
            lib.makeLibraryPath [
              stdenv.cc.cc
              zlib
              glib
              libxcb
              libglvnd
            ];

          packages = pkgs.lib.flatten [
            (with pkgs; [
            ])
            (with unstable; [
              typst
              typstyle
            ])
            fonts
          ];
          shellHook = ''
            unset SOURCE_DATE_EPOCH
          '';
          env = {
            FONTCONFIG_FILE = pkgs.makeFontsConf {
              fontDirectories = fonts;
            };
          };
          buildInputs = [ pkgs.bashInteractive ];
        };
      }
    );
}

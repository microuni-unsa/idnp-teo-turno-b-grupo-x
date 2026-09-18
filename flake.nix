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
        fonts = with pkgs; [ lato ];
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
              android-tools
              jdk21
              gradle
            ])
            (with unstable; [
              typst
              typstyle
              android-cli
              tinymist
            ])
            fonts
          ];
          shellHook = ''
            unset SOURCE_DATE_EPOCH
            export ANDROID_HOME="''${ANDROID_HOME:-$HOME/Android/Sdk}"
            export ANDROID_SDK_ROOT="''${ANDROID_SDK_ROOT:-$ANDROID_HOME}"
            export JAVA_HOME="''${JAVA_HOME:-${pkgs.jdk21.home}}"
            export PATH="$JAVA_HOME/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
          '';
          env = {
            FONTCONFIG_FILE = pkgs.makeFontsConf {
              fontDirectories = fonts;
            };
            JAVA_HOME = pkgs.jdk21.home;
          };
          buildInputs = [ pkgs.bashInteractive ];
        };
      }
    );
}

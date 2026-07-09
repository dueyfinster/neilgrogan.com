{
  description = "my blog";

  outputs = inputs @ {
    self,
    flake-parts,
    nixpkgs,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.devshell.flakeModule
      ];

      systems = [
        "x86_64-darwin"
        "x86_64-linux"
        "aarch64-darwin"
        "aarch64-linux"
      ];
      perSystem = {
        config,
        pkgs,
        lib,
        ...
      }: {
        formatter = pkgs.alejandra;

        packages.default = pkgs.stdenv.mkDerivation {
          name = "neilgrogan-com";
          src = self;
          nativeBuildInputs = [pkgs.hugo pkgs.git];
          buildPhase = "hugo --minify";
          installPhase = "cp -r public $out";
        };

        checks.formatting = pkgs.runCommand "check-formatting" {
          nativeBuildInputs = [pkgs.alejandra];
        } ''
          alejandra -c ${self} && touch $out
        '';

        devshells.default = {
          commands = [
            {package = pkgs.hugo;}
            {
              name = "dev";
              help = "Run the hugo server";
              command = ''
                (sleep 1 ; open http://localhost:1313/) &
                exec hugo server --noHTTPCache --buildDrafts --buildFuture "$@"
              '';
            }
            {
              name = "new-post";
              help = "Create a new post with '[plain-title]'";
              command = ''
                set -eu -x
                date="$(date -Idate)"
                year="$(date +%Y)"
                title_plain="$1"; shift
                title="$(echo "$title_plain" | tr ' A-Z' '-a-z')"

                hugo new content -k post "$@" content/post/"$year"/"$date"-"$title".md
                "$EDITOR" content/post/"$year"/"$date"-"$title".md
              '';
            }
          ];
          packages = with pkgs; [go git nodePackages.prettier];
        };
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

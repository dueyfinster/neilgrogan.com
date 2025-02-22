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
        final,
        ...
      }: {
        formatter = pkgs.alejandra;

        devshells.default = {
          commands = [
            {package = pkgs.hugo;}
            {
              name = "dev";
              help = "Run the hugo server";
              command = ''
                (sleep 1 ; open http://localhost:1313/) &
                exec hugo server --noHTTPCache --buildDrafts --buildFuture \"$@\"
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
    flake-parts.url = "github:hercules-ci/flake-parts";
    devshell.url = "github:numtide/devshell";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    nix-flake-tests.url = "github:antifuchs/nix-flake-tests";
  };
}

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # yolo. And we're making a flake.lock anyway.
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
    nixpkgs-python.url = "github:cachix/nixpkgs-python"; # required to set Python version
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = {
    self,
    nixpkgs,
    devenv,
    systems,
    ...
  } @ inputs: let
    forEachSystem = nixpkgs.lib.genAttrs (import systems);
  in {
    devShells =
      forEachSystem
      (system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        default = devenv.lib.mkShell {
          inherit inputs pkgs;
          modules = [
            {
              # https://devenv.sh/reference/options/
              packages = [
                pkgs.zlib
              ];
              languages.python = {
                enable = true;
                version = "3.11"; # specifying version requires the nixpkgs-python input, above.
                poetry = {
                  enable = true;
                  install.enable = true;
                  install.allExtras = true;
                };
              };

              enterShell = ''
                echo ""
                echo "hey there "
                echo "this is an example devenv setup "
                echo "using flakes for a poetry-based python project."
                echo "check out https://devenv.sh/guides/using-with-flakes/#getting-started "
                echo "and https://github.com/cachix/devenv/tree/main/examples/python-poetry. "
                echo "the poetry example from the cachix github uses the non-flake version of devenv, but the translation was straightforward."
                echo ""
              '';
            }
          ];
        };
      });
  };
}

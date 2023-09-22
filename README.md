# Nix + flakes + devenv + Python + Poetry = 🤘

This is a template for Python projects
managed by Poetry (`pyproject.toml`),
and further declaratively managed with Nix flakes,
using the delightful [devenv](https://devenv.sh/)

I'm using this on NixOS, 
where it all fits very nicely together,
but as long as Nix is installed, it should work just fine.

I used the [flakes guide from devenv](https://devenv.sh/guides/using-with-flakes/), 
and combined it with the Python poetry [example](https://github.com/cachix/devenv/tree/main/examples/python-poetry) they have on their github
(which doesn't use flakes).

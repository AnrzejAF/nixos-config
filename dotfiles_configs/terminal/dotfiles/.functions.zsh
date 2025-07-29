nix_rebuild() {
  sudo nixos-rebuild switch --flake '.#anrzej-nix'
}

nix_flake_update() {
    nix flake update
}

nix_flake_meta() {
    nix flake metadata
}

nix_cleanup() {
  sudo nix-collect-garbage -d
  nix-store --gc
  nix-store --optimize
}

nix_full_update() {
  nix_flake_update
  nix_rebuild
  nix_cleanup
}

nix_run() {
  local pkg="$1"
  shift
  nix run "nixpkgs#${pkg}" -- "$@"
}

nix_shell() {
  nix shell "$@"
}

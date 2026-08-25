full deploy nix config

`nix run github:nix-community/nixos-anywhere -- --generate-hardware-config nixos-generate-config ./homeserver/hardware.nix --flake .#homeserver --target-host nixos@192.
168.1.118`

rebuild switch remote

`nixos-rebuild switch --flake .#homeserver --target-host "charles@192.168.1.118" --sudo --ask-sudo-password`

nix-shell -p sops --run "sops secrets/example.yaml"
$ mkdir -p ~/.config/sops/age
$ nix-shell -p ssh-to-age --run "ssh-to-age -private-key -i ~/.ssh/id_ed25519 > ~/.config/sops/age/keys.txt"

full deploy nix config

`nix run github:nix-community/nixos-anywhere -- --generate-hardware-config nixos-generate-config ./homeserver/hardware.nix --flake .#homeserver --target-host nixos@192.
168.1.118 `


rebuild switch remote 

`nixos-rebuild switch --flake .#homeserver --target-host "charles@192.168.1.118" --sudo --ask-sudo-password`

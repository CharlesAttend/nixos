{
  description = "A SecureBoot-enabled NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # lanzaboote = {
    #   url = "github:nix-community/lanzaboote/v0.4.2";

    #   # Optional but recommended to limit the size of your system closure.
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, ...}@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # This is not a complete NixOS configuration and you need to reference
          # your normal configuration here.
          ./configuration.nix

          # lanzaboote.nixosModules.lanzaboote
          # ({ pkgs, lib, ... }: {
          #   # Lanzaboote currently replaces the systemd-boot module.
          #   # This setting is usually set to true in configuration.nix
          #   # generated at installation time. So we force it to false
          #   # for now.
          #   boot.loader.systemd-boot.enable = lib.mkForce false;

          #   boot.lanzaboote = {
          #     enable = true;
          #     pkiBundle = "/var/lib/sbctl";
          #   };
          # })

          
        ];
      };
    };
  };
}
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # musnix.url = "github:musnix/musnix";
    # musnix.inputs.nixpkgs.follows = "nixpkgs";
    # companion.url = "github:noblepayne/bitfocus-companion-flake";
    # companion.inputs.nixpkgs.follows = "nixpkgs";

    inputs.disko.url = "github:nix-community/disko/latest";
    inputs.disko.inputs.nixpkgs.follows = "nixpkgs";

    prettyswitch.url = "github:noblepayne/pretty-switch";
    prettyswitch.inputs.nixpkgs.follows = "nixpkgs";
    
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, prettyswitch, hyprland, disko, ... }: {
    # Formatter (optional)
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    nixosConfigurations = {
      nix-vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nix-vm/system.nix
          prettyswitch.nixosModules.default
          disko.nixosModules.disko
          # Import your disko-config.nix
          ./hosts/nix-vm/disko-config.nix
        ];
        specialArgs = {
          inherit hyprland;
        };
      };
      nix-ltp = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nix-ltp/system.nix
          prettyswitch.nixosModules.default
          disko.nixosModules.disko
          # Import your disko-config.nix
          ./hosts/nix-ltp/disko-config.nix
        ];
        specialArgs = {
          inherit hyprland;
        };
      };
      installer = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # Graphical ISO with Calamares (Plasma)
          (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-plasma5.nix")
          # Optional: add extra tools to the live ISO
          ({ pkgs, ... }: {
            environment.systemPackages = with pkgs; [
              neovim
              git
              firefox
              btop
            ];
          })
        ];
      };
    };
  };
}

{
  description = "Nixos configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # nixpkgs.url = "nixpkgs/nixos-23.05";
    nixos-hardware.url = "github:Nixos/nixos-hardware/master";
    home-manager = {
      url = "github:/nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-secrets = {
      url = "git+ssh://git@github.com/SamuelSehnert/NixOS-Secrets";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-flake = {
      url = "github:SamuelSehnert/neovim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-flake = {
      url = "github:SamuelSehnert/emacs-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixos-hardware
    , home-manager
    , nixos-secrets
    , ...
    } @inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          inputs.neovim-flake.overlays.default
          inputs.emacs-flake.overlays.default
        ];
      };
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;

      nixosConfigurations =
        let
          secrets = nixos-secrets.nixosModules.default;
          machines = [
            {
              hostname = "CSC";
              description = "My main Thinkpad t480 laptop";
              usernames = [ "squid" ];
              hardware = [ nixos-hardware.nixosModules.lenovo-thinkpad-t480 ];
            }
            {
              hostname = "galaxy";
              description = "Dell Optiplex server and backup store";
              usernames = [ "octopus" ];
              hardware = with nixos-hardware.nixosModules; [
                common-cpu-intel
                common-pc-hdd
              ];
            }
          ];
        in
        builtins.listToAttrs (
          builtins.map
            (machine: {
              name = machine.hostname;
              value = nixpkgs.lib.nixosSystem {
                inherit system pkgs;
                specialArgs = {
                  inherit inputs machine secrets;
                };
                modules = [
                  home-manager.nixosModules.home-manager
                  {
                    home-manager = {
                      useGlobalPkgs = true;
                      useUserPackages = true;
                      users = with builtins;
                        listToAttrs (builtins.map
                          (name: {
                            name = name;
                            value = import ./homes/${name} {
                              inherit pkgs;
                              config = {
                                inherit nixos-secrets;
                                username = name;
                              };
                            };
                          })
                          machine.usernames);
                    };
                  }
                  ./system/hosts/${machine.hostname}
                ] ++ machine.hardware;
              };
            })
            machines
        );
    };
}

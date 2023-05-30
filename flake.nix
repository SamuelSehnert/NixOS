{
    description = "Nixos configuration";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        nixos-hardware.url = "github:Nixos/nixos-hardware/master";
        home-manager = {
            url = "github:/nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        neovim-flake = {
            url = "github:SamuelSehnert/neovim-flake";
        };
    };

    outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs: let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
                inputs.neovim-flake.overlays.default
            ];
        };
    in {
        nixosConfigurations = let
            machines = [
                {
                    hostname = "CSC";
                    description = "My main Thinkpad t480 laptop";
                    usernames = [ "squid" ];
                    swapSize = 8;
                    enableHibernate = true;
                    hardware = [ nixos-hardware.nixosModules.lenovo-thinkpad-t480 ];
                }
                {
                    hostname = "galaxy";
                    description = "Dell Optiplex server and backup store";
                    usernames = [ "octopus" ];
                    swapSize = 8;
                    hardware = with nixos-hardware.nixosModules; [
                        common-cpu-intel
                        common-pc-hdd
                    ];
                }
            ];
        in builtins.listToAttrs (
            builtins.map(machine: {
                name = machine.hostname;
                value = nixpkgs.lib.nixosSystem {
                    inherit system pkgs;
                    specialArgs = { inherit inputs machine; };
                    modules = [
                        home-manager.nixosModules.home-manager {
                            home-manager = {
                                useGlobalPkgs = true;
                                useUserPackages = true;
                                users =  with builtins;
                                    listToAttrs (builtins.map (name: {
                                        name = name;
                                        value = import ./homes/${name} {
                                            inherit pkgs;
                                            config = {
                                                username = name;
                                            };
                                        };
                                    }) machine.usernames);
                            };
                        }
                        ./system/hosts/${machine.hostname}
                        ./hardware-configuration.nix
                    ] ++ machine.hardware;
                };
            }) machines
        );
    };
}

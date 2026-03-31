{
  description = "Ekkirami's NixOS flake";

  inputs = {
    nixpkgs.url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=nixos-25.11&shallow=1";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.Rami-Nix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        # home-manager
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ekkirami = import ./home.nix;
        }
      ];
    };
  };
}

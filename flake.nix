{
  description = "Ekkirami's NixOS flake";

  inputs = {
    nixpkgs.url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=nixos-25.05&shallow=1";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.Rami-Nix = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
      ];
    };
  };
}
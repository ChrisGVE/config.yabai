{
  description = "Chris nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, ... }:
    let
      configuration = { pkgs, config, ... }: {

        nixpkgs.config.allowUnfree = true;

        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages =
          [
            # pkgs.conda
            pkgs._1password
            pkgs.ast-grep
            pkgs.automake
            pkgs.bat
            pkgs.btop
            pkgs.cargo
            pkgs.cmake
            pkgs.curl
            pkgs.deno
            pkgs.direnv
            pkgs.discord
            pkgs.docker
            pkgs.docutils
            pkgs.espanso
            pkgs.fd
            pkgs.fzf
            pkgs.fzy
            pkgs.gcc-arm-embedded
            pkgs.gh
            pkgs.git
            pkgs.gitui
            pkgs.glow
            pkgs.gnused
            pkgs.go
            pkgs.httrack
            pkgs.hub
            pkgs.kitty
            pkgs.lazygit
            pkgs.man
            pkgs.mkalias
            pkgs.mosh
            pkgs.multitail
            pkgs.neovim
            pkgs.nodejs_22
            pkgs.obsidian
            pkgs.ocaml
            pkgs.oh-my-zsh
            pkgs.opam
            pkgs.pandoc
            pkgs.perl
            pkgs.pipx
            pkgs.pnpm
            pkgs.pyenv
            pkgs.python311
            pkgs.python312
            pkgs.python313
            pkgs.reattach-to-user-namespace
            pkgs.rustc
            pkgs.sketchybar
            pkgs.sphinx
            # pkgs.terraform
            pkgs.tmux
            pkgs.tree
            pkgs.universal-ctags
            pkgs.viu
            pkgs.yarn
            pkgs.yazi
            pkgs.zoxide
            pkgs.zsh
            pkgs.zsh-syntax-highlighting
          ];

        homebrew = {
          enable = true;
          brews = [
            "mas"
          ];
          casks = [
            # "felixkratz/formulae/borders"
            "aerospace"
          ];
          masApps = {
            "Notability" = 360593530;
          };
          onActivation.cleanup = "zap";
        };

        fonts.packages = [
          (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        ];

        system.activationScripts.applications.text =
          let
            env = pkgs.buildEnv {
              name = "system-applications";
              paths = config.environment.systemPackages;
              pathsToLink = "/Applications";
            };
          in
          pkgs.lib.mkForce ''
            # Set up applications.
            echo "setting up /Applications..." >&2
            rm -rf /Applications/Nix\ Apps
            mkdir -p /Applications/Nix\ Apps
            find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
            while read -r src; do
              app_name=$(basename "$src")
              echo "copying $src" >&2
              ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
            done
          '';

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Enable alternative shell support in nix-darwin.
        programs.zsh.enable = true; # default shell
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "x86_64-darwin";
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."nAragorn" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              user = "chris";
              autoMigrate = true;
              # taps = {
              #   "homebrew/homebrew-core" = homebrew-core;
              #   "homebrew/homebrew-cask" = homebrew-cask;
              #   "homebrew/homebrew-bundle" = homebrew-bundle;
              # };
              # mutableTaps = false;
            };
          }
        ];
      };
      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."nAragorn".pkgs;
    };
}

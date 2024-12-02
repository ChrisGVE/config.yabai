{
  description = "Chris nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-stable";
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
    whalebrew = {
      url = "github:whalebrew/whalebrew";
      flake = false;
    };
    # SFMono w/ patches
    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };
  };

  outputs =
    inputs@{ self
    , nix-darwin
    , nixpkgs
    , nix-homebrew
    , homebrew-core
    , homebrew-cask
    , homebrew-bundle
    , whalebrew
    , sf-mono-liga-src
    }:

    let
      configuration = { pkgs, config, ... }: {

        nixpkgs.config.allowUnfree = true;

        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages = with pkgs;
          [
            # _1password-gui
            # terraform
            _1password
            ast-grep
            automake
            bat
            btop
            cargo
            cmake
            curl
            deno
            direnv
            docker
            docutils
            fd
            fzf
            fzy
            gh
            git
            gitui
            glow
            gnused
            go
            httrack
            hub
            lazygit
            lua
            man
            mkalias
            mosh
            multitail
            neovim
            nodejs_22
            # ocaml
            oh-my-zsh
            # opam
            pandoc
            perl
            pipx
            pnpm
            pyenv
            python311
            python312
            python313
            reattach-to-user-namespace
            ripgrep
            ruby
            rust-analyzer
            rustc
            silver-searcher
            sketchybar
            sphinx
            tmux
            tree
            universal-ctags
            viu
            wget
            yarn
            yazi
            zed
            zig
            zip
            zoxide
            zsh
            zsh-syntax-highlighting
            zsh-fast-syntax-highlighting
            zsh-autosuggestions
            zsh-completions
            nix-zsh-completions
            zsh-vi-mode
            broot
          ];

        homebrew = {
          enable = true;
          whalebrews = [ ];
          taps = [
            "FelixKratz/formulae"
            "nikitabobko/tap"
            "qmk/qmk"
            "osx-cross/arm"
            "osx-cross/avr"
            "jandedobbeleer/oh-my-posh"
          ];
          brews = [
            "oh-my-posh"
            "borders"
            "mas"
            "qmk"
            "sketchybar"
            "whalebrew"
            # dependencies for qmk (listed to prevent attempt at uninstalling each time)
            # "osx-cross/arm/arm-none-eabi-gcc"
            "osx-cross/avr/avr-gcc"
            "avrdude"
            "bootloadhid"
            "ca-certificates"
            "cairo"
            "clang-format"
            "dfu-programmer"
            "dfu-util"
            "fontconfig"
            "freetype"
            "fribidi"
            "gettext"
            "giflib"
            "glib"
            "gmp"
            "graphite2"
            "harfbuzz"
            "hid_bootloader_cli"
            "hidapi"
            "isl"
            "jpeg-turbo"
            "libimagequant"
            "libmpc"
            "libpng"
            "libraqm"
            "libtiff"
            "libunistring"
            "libusb-compat"
            "libx11"
            "libxau"
            "libxcb"
            "libxdmcp"
            "libxext"
            "libxrender"
            "little-cms2"
            "lz4"
            "lzo"
            "make"
            "mdloader"
            "mpdecimal"
            "mpfr"
            "openjpeg"
            "openssl"
            "pcre2"
            "pillow"
            "pixman"
            "python"
            "python-packaging"
            "readline"
            "sqlite"
            "teensy_loader_cli"
            "webp"
            "xorgproto"
            "xz"
            "zstd"
          ];
          casks = [
            "alacritty"
            "1password"
            "adobe-acrobat-reader"
            "aerospace"
            "alfred"
            "backblaze"
            "calibre"
            "chronosync"
            "daisydisk"
            "devonagent"
            "devonthink"
            "discord"
            "dropbox"
            "epic-games"
            "espanso"
            "firefox"
            "font-sketchybar-app-font" # Required for sketchybar
            "fork"
            "google-chrome"
            "google-drive"
            "grammarly-desktop"
            "iterm2"
            "jabra-direct"
            "karabiner-elements"
            "keyboard-maestro"
            "keycue"
            "kitty"
            "logi-options+"
            "lulu"
            "miniconda"
            "moom"
            "notion"
            "obsidian"
            "omnifocus"
            "omnigraffle"
            "omnioutliner"
            "omniplan"
            "only-switch"
            "plus42-decimal"
            "qmk-toolbox"
            "setapp"
            "sf-symbols"
            "snagit"
            "soundsource"
            "spamsieve"
            "steam"
            "tageditor"
            "tradingview"
            "transmission"
            "transmit"
            "trezor-suite"
            "vlc"
            "wins"
            "zed"
            "wezterm"
          ];
          masApps = {
            "1Password for Safari" = 1569813296;
            "Actions" = 1586435171;
            "AdBlock Pro" = 1018301773;
            "AdGuard for Safari" = 1440147259;
            "Aiko" = 1672085276;
            "AudioBookBinder" = 413969927;
            "Audiobook Wizard" = 460967298;
            "Cardhop" = 1290358394;
            "Cheatsheet" = 1468213484;
            "Cityscapes" = 1631153096;
            "CleanMyDrive 2" = 523620159;
            "Coin Stats" = 1498417304;
            "Darkroom" = 953286746;
            "Data Jar" = 1453273600;
            "Deliveries" = 924726344;
            "Developer" = 640199958;
            "Disk Speed Test" = 425264550;
            "Encrypto" = 935235287;
            "Fantastical" = 975937182;
            "Focus" = 777233759;
            "Goodnotes" = 1444383602;
            "Grammarly for Safari" = 1462114288;
            "Ground News" = 1324203419;
            "HP Smart" = 1474276998;
            "Keynote" = 409183694;
            "Kiwix" = 997079563;
            "Live Wallpaper" = 531123879;
            "Menu Box" = 6463440793;
            "NordVPN" = 905953485;
            "Notability" = 360593530;
            "Numbers" = 409203825;
            "OneDrive" = 823766827;
            "PCalc" = 403504866;
            "Pages" = 409201541;
            "PayPal Honey" = 1472777122;
            "Photomator" = 1444636541;
            "Reeder" = 6475002485;
            "Save to Medium" = 1485294824;
            "Shazam" = 897118787;
            "Shortery" = 1594183810;
            "ShutterCount" = 720123827;
            "SimpleumSafe" = 1547771496;
            "Slack" = 803453959;
            "Speedtest" = 1153157709;
            "Texifier" = 458866234;
            "The Unarchiver" = 425424353;
            "Tot" = 1491071483;
            "Userscripts-Map-App" = 1463298887;
            "WhatsApp" = 310633997;
            "Xcode" = 497799835;
            "iA Writer" = 775737590;
            "iMovie" = 408981434;
          };
          onActivation.cleanup = "zap";
          onActivation.autoUpdate = true;
          onActivation.upgrade = true;
        };

        fonts.packages = with pkgs; ([
          sf-mono-liga-bin
          monaspace
        ]) ++ (

          with pkgs.nerd-fonts; [
            bigblue-terminal
            caskaydia-cove
            caskaydia-mono
            comic-shanns-mono
            dejavu-sans-mono
            envy-code-r
            fira-code
            fira-mono
            hack
            im-writing
            inconsolata
            inconsolata-go
            iosevka
            iosevka-term
            iosevka-term-slab
            jetbrains-mono
            lilex
            meslo-lg
            open-dyslexic
            sauce-code-pro
            symbols-only
            victor-mono
            zed-mono
          ]
        );

        nixpkgs.overlays =
          [
            (final: prev: {
              sf-mono-liga-bin = prev.stdenvNoCC.mkDerivation rec {
                pname = "sf-mono-liga-bin";
                version = "dev";
                src = inputs.sf-mono-liga-src;
                dontConfigure = true;
                installPhase = ''
                  mkdir -p $out/share/fonts/opentype
                  cp -R $src/*.otf $out/share/fonts/opentype/
                '';
              };
            })
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

        system.defaults = {
          dock.autohide = true;
          dock.persistent-apps = [
            "/Applications/Setapp/Path Finder.app"
            "/System/Applications/Mail.app"
            "/Applications/Setapp/Spark Mail.app"
            "/System/Applications/Messages.app"
            "/Applications/WhatsApp.app"
            "/System/Applications/System Settings.app"
            "/Applications/1Password.app"
            "/Applications/Fantastical.app"
            "/Applications/OmniFocus.app"
            "/Applications/Cardhop.app"
            "/Applications/Safari.app"
            "/System/Applications/Music.app"
            "/Applications/Notability.app"
            "/Applications/kitty.app"
            "/Applications/Citrix Workspace.app"
            "/Applications/Obsidian.app"
            "/Applications/Parallels Desktop.app"
            "/System/Applications/iPhone Mirroring.app"
          ];
          loginwindow.GuestEnabled = false;
          NSGlobalDomain.AppleInterfaceStyle = "Dark";
        };

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
      # $ darwin-rebuild build --flake .#nAragorn
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

{ pkgs, lib, config, nix-colors, ... }:

with lib;

let
  cfg = config.nixColorsContrib;

  lib-contrib = nix-colors.lib-contrib { inherit pkgs; };

  shellTheme = lib-contrib.shellThemeFromScheme { scheme = config.colorScheme; };
in
{
  options.nixColorsContrib = {
    enable = mkEnableOption "contrib options for nix-colors";

    enableBashIntegration = mkOption {
      default = true;
      type = types.bool;
      description = ''
        Whether to enable Bash integration.
      '';
    };

    enableZshIntegration = mkOption {
      default = true;
      type = types.bool;
      description = ''
        Whether to enable Zsh integration.
      '';
    };

    enableFishIntegration = mkOption {
      default = true;
      type = types.bool;
      description = ''
        Whether to enable Fish integration.
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.bash.initExtra = mkIf cfg.enableBashIntegration ''
      sh ${shellTheme}
    '';

    programs.zsh.initExtra = mkIf cfg.enableZshIntegration ''
      sh ${shellTheme}
    '';

    programs.fish.interactiveShellInit = mkIf cfg.enableFishIntegration ''
      sh ${shellTheme}
    '';
  };
}


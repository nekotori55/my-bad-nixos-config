{ lib, config, ... }:
let
  keybinds = config.programs.gnome-shell.custom-keybindings;
in
with lib;
{
  options.programs.gnome-shell = {
    custom-keybindings = mkOption {
      type = types.attrsOf (
        types.submodule {
          options.binding = mkOption {
            type = types.str;
            description = "Key combination in dconf format TODO";
          };

          options.command = mkOption {
            type = types.str;
            description = "Command to execute";
          };
        }
      );

      default = { };
    };
  };

  config = mkIf config.programs.gnome-shell.enable {
    dconf = {
      enable = mkDefault true;

      settings =
        let
          keybind-base-path = "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings";
          indexedKeybinds = removeAttrs (foldlAttrs
            (
              acc: name: value:
              acc
              // {
                current_index = acc.current_index + 1;
                ${name} = {
                  binding = value.binding;
                  command = value.command;
                  name = name;
                  index = acc.current_index;
                };
              }
            )
            {
              current_index = 0;
            }
            keybinds
          ) [ "current_index" ];
        in
        {
          "org/gnome/settings-daemon/plugins/media-keys" = {
            custom-keybindings = mapAttrsToList (
              name: value: "/${keybind-base-path}/custom${builtins.toString value.index}/"
            ) indexedKeybinds;
          };
        }
        // mapAttrs' (
          name: value:
          nameValuePair "${keybind-base-path}/custom${builtins.toString value.index}" {
            name = name;
            binding = value.binding;
            command = value.command;
          }
        ) indexedKeybinds;
    };
  };
}

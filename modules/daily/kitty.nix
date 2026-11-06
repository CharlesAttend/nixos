{ config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    font = {
      name = "Droid Sans Mono";
      size = 14;
    };
    extraConfig = ''
      notify_on_cmd_finish invisible 10.0
      remember_window_size no 
    ''; # remember_window_size https://github.com/kovidgoyal/kitty/issues/10442
  };
}

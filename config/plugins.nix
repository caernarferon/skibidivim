{ pkgs, ... }: {
  plugins = {
    persistence.enable = true;
    notify.enable = true;
  };
}

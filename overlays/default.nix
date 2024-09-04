{ ... }:
{
  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: {
    discord = prev.discord.override {
      withOpenASAR = true;
      withVencord = true;
    };
  };
}

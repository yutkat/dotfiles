{ pkgs, ... }:

{
  fonts = {
    packages = (
      with pkgs;
      [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        fira-code
        fira-code-symbols
        dina-font
        proggyfonts
        udev-gothic-nf
        font-awesome
        cantarell-fonts
      ]
    );

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "UDEV Gothic 35NFLG" ];
        sansSerif = [
          "Noto Sans CJK JP"
          "DejaVu Sans"
        ];
        serif = [
          "Noto Serif JP"
          "DejaVu Serif"
        ];
      };
      subpixel = {
        lcdfilter = "light";
      };
    };
  };
}

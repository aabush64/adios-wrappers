_: {
  options.theme.mutators = ["/themeJet"];

  mutations."/themeJet".theme = let
    inherit (builtins) mapAttrs;
  in
    _:
      mapAttrs (
        name: value: {HEX = value;}
      )
      {
        # Background Colors 0-7
        bg0 = "#1D2021";
        bg1 = "#282828";
        bg2 = "#32302F";
        bg3 = "#3C3836";
        bg4 = "#504945";
        bg5 = "#665C54";
        bg6 = "#7C6F64";
        bg7 = "#928374";

        # Foreground Colors 0-7
        fg0 = "#EBDBB2";
        fg1 = "#DFCEA9";
        fg2 = "#D2C1A0";
        fg3 = "#C6B497";
        fg4 = "#B9A78E";
        fg5 = "#AC9B85";
        fg6 = "#9F8F7D";
        fg7 = "#928374";

        # Reds
        redDiff = "#3C1F1E";
        redVis = "#442E2D";
        redDark = "#9D0006";
        red = "#CC241D";
        redLight = "#FB493F";

        # Greens
        greenDiff = "#32361A";
        greenVis = "#333E34";
        greenDark = "#79740E";
        green = "#98971A";
        greenLight = "#B8BB26";

        # Yellows
        yellowDiff = "#3B2D16";
        yellowVis = "#473C29";
        yellowDark = "#B57614";
        yellow = "#D79921";
        yellowLight = "#FABD2F";

        # Blues (brothers)
        blueDiff = "#0D3138";
        blueVis = "#2E3B38";
        blueDark = "#076678";
        blue = "#458588";
        blueLight = "#83A598";

        # Purples
        purpleDiff = "#39192D";
        purpleVis = "#3C333B";
        purpleDark = "#8F3F71";
        purple = "#B16286";
        purpleLight = "#D3869B";

        # Aquas
        aquaDiff = "#213C2B";
        aquaVis = "#455040";
        aquaDark = "#427B58";
        aqua = "#689D6A";
        aquaLight = "#8EC07C";

        # Oranges
        orangeDiff = "#4A1D08";
        orangeVis = "#5B4533";
        orangeDark = "#AF3A03";
        orange = "#D65D0E";
        orangeLight = "#FE8019";

        # Grays
        grayDiff = "#3B3530";
        grayVis = "#5B5349";
        grayDark = "#7C6F64";
        gray = "#928734";
        grayLight = "#9F8F7D";

        # B/W
        black = "#141617";
        white = "#FBF1C7";
      };
}

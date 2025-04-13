{lib, ...}: let
  inherit (lib) concatStrings;
in {
  format = concatStrings [
    "$username"
    "$directory"
    "$git_branch"
    "$git_status"
    "$fill"
    "$c"
    "$elixir"
    "$elm"
    "$golang"
    "$haskell"
    "$java"
    "$julia"
    "$nodejs"
    "$nim"
    "$rust"
    "$scala"
    "$conda"
    "$python"
    "$time\n  "
    "[󱞪](fg:iris) "
  ];

  palettes.rose-pine = {
    overlay = "#26233a";
    love = "#eb6f92";
    gold = "#f6c177";
    rose = "#ebbcba";
    pine = "#31748f";
    foam = "#9ccfd8";
    iris = "#c4a7e7";
  };
  palette = "rose-pine";

  # TODO: Complete further.
}

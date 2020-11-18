let
  pkgs = import <nixpkgs> {  };
  tools = with pkgs; [
    hugo
    gnumake
    ghc
    hello
    tree
  ];
in
pkgs.mkShell {
  buildInputs = tools;
}

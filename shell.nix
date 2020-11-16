let
  pkgs = import <nixpkgs> {  };
  tools = with pkgs; [
    hugo
    gnumake
    ghc
    hello
  ];
in
pkgs.mkShell {
  buildInputs = tools;
}

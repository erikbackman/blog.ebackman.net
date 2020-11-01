let
  pkgs = import <nixpkgs> {  };
  tools = with pkgs; [
    hugo
    gnumake
    ghc
  ];
in
pkgs.mkShell {
  buildInputs = tools;
}

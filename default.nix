let
  pkgs = import <nixpkgs> {  };
  tools = with pkgs; [
    hugo
  ];
in
pkgs.mkShell {
  buildInputs = tools;
}

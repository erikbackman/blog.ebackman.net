let
  pkgs = import <nixpkgs> {  };
  tools = with pkgs; [
    hugo
    gnumake
  ];
in
pkgs.mkShell {
  buildInputs = tools;
}

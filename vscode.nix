# NIXPKGS_ALLOW_UNFREE=1 nix-shell vscode.nix

with (import <unstable> {});


let
extensions = (with pkgs.vscode-extensions; [
    bbenoist.Nix
    ms-vsliveshare.vsliveshare
]);
vscode-with-extensions = pkgs.vscode-with-extensions.override {
    vscodeExtensions = extensions;
};
in
mkShell rec {
    name = "with-vs-code";

        buildInputs = [
            vscode-with-extensions
        ];

}
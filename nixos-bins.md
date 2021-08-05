getting an external binary to work on nixos

- download the binary
- run it, get bin/julia: command not found
- run `ldd bin/julia`, see that some of them are pointing to nix, some of them aren't

run 
```
patchelf --set-interpreter /nix/store/q53f5birhik4dxg3q3r2g5f324n7r5mc-glibc-2.31-74/lib/ld-linux-x86-64.so.2 bin/julia
```

voila
# Replace it

CLI application that find and replace string in files.
Usage:

```bash
replace 'old text' 'new text'
replace -o old-text -n new-text -d ./search_path

# replace file name to use `-p`
replace -o old-text -n new-text -d ./search_path -p t
```

Installing V
```bash
wget https://github.com/vlang/v/releases/latest/download/v_macos.zip
unzip v_macos.zip
cd v
sudo ./v symlink
```

Now V should be globally available on your system.
On macOS use v_macos.zip, on Windows - v_windows.zip. If you use a BSD system, Solaris, Android, or simply want to install V from source, follow the simple instructions here: https://github.com/vlang/v#installing-v-from-source

Upgrading V to latest version
```bash
v up
```
Follow the simple instructions here: https://github.com/vlang/v/blob/master/doc/docs.md

Build `replace` CLI
```bash
v -prod . -o bin/replace && ./scripts/install_replace.vsh
```

Link `replace` CLI
```bash
./scripts/install_replace.vsh
```
 and call `replace` from any path.

Make release
```bash
./scripts/release.vsh && ./scripts/install_replace.vsh
```

TODO:

    * Tests
    * Performance benchmarks
    * Home brew formula
    * More features

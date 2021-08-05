# Preparing the Laptop
First, obviously, back everything up.

Then, prepare the hard drive. This will assume it's installing on a computer with a single hard-drive, and not dual-booting.

_To do: test and record dual-boot install instructions._

It’s entirely possible to do everything from the minimal image, but partitioning the hard-drive from the command-line is a pain in the ass. Make a boot USB with something that has a nice graphical interface, and use Gparted to handle the partitions.

_To do: I did the command line recently, and it wasn't godawful, so I can record

So, before you begin, make sure you have:
1. A second laptop, to read the docs while you're installing on the main one.
2. An ethernet connection, cause connecting to the wi-fi from the command line will waste an hour of your life that you can never get back.
3. Two USBs, one with Arch and another with something with Gparted.

I don’t do separate home and root dirs anymore. So we only need three partitions.

1. Wipe the hard-drive.
2. Create the boot partition. It _must_ be fat32. Make it 512 MB. I'm not 100% sure what the label does, but set it to ESP, and the name to boot.
3. Make a swap partition. I can never tell if this is necessary, but just make it 4Gb. Remember to set the file-system to linux-swap. I set the name and label to swap.
4. Make the root partition. It'll be the rest of the space, and file-system is ext4. Set the name and label to rootfs.
5. After the partitions have been created, right-click on the boot partition, go to Manage Flags, and give it the `boot` and `esp` flags.

_To do: I don't remember what happens next with Nixos_

# Set up Nixos
Merge/copy the configuration.nix and build the system.

The first time you log in, do it as root, and then set the password for the main user. Then you can log out and log back in as the user.

## Set up i3
Touch `.xinitrc`, which is the thing that'll run when you run `startx`. Write to it:
```
setxkbmap gb # set the keyboard layout for X

exec i3      # start i3
```
If you want a desktop image, you can add feh there too. There is almost certainly a way to set the keyboard map in the Nix config, but I haven't gotten it to work yet.

## Set up user-software
Add channels for the user. If Nix doesn't find a channel it will fall back on the system packages, but it's convenient to be able to use unstable packages.
```
nix-channel --add https://nixos.org/channels/nixos-20.09 stable
nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
```

Install core user software, with `nix-env -i <pckgs>`. A good starting list is 
- acpi
- alacritty
- awscli
- breeze-gtk
- feh
- firefox
- git
- jetbrains.jdk
- leiningen
- meld
- moc
- poetry
- rofi
- sysstat
- udiskie
- unzip
- vscodium
- wireless-tools

### Configs
You may need to create some dirs if the apps haven't been used yet.
```
# i3
cp i3 ~/.config/i3/config
cp i3blocks/ ~/.config/i3blocks
cp XCompose ~/.XCompose

# zsh
cp prompt_michael_setup ~/.zprezto/modules/prompt/functions/prompt_michael_setup
cp zpreztorc ~/.zprezto/runcoms/zpreztorc
cp zshrc ~/.zprezto/runcoms/zshrc

# apps
cp alacritty.yml ~/.config/alacritty/alacritty.yml
cp gitconfig ~/.gitconfig
cp .gitignore_global ~/.gitignore_global
cp moc ~/.moc/config
cp vscode/User/* ~/.config/VSCodium/User/
cp vscode/User/* ~/.config/Code/User/

# appearance
cp index.theme ~/.icons/default/index.theme
cp settings.ini ~/.config/gtk-3.0/settings.ini
```

Meld uses dconf rather than a static config file. To export meld settings `dconf /org/gnome/meld/ > meld.dconf`, and to import `dconf load /org/gnome/meld/ < meld.dconf`. If you're not sure what the name is, `gsettings list-schemas` will print out a list.

### Removeable Media
Filesystem packages must be installed at the system level, they can't be per-user installed. Just run udiskie to automatically mount the drive. 

### Intellij
Intellij products actually work pretty fine from /opt, with a shortcut in /usr/local/bin. I had to create /usr/local/bin/, but it's already on the path.

Just install jetbrains.jdk and replace the intellij java bin with a link to the nix one. It looks something like `sudo ln -s /nix/store/fd7ys22m5j9dxxvn5qgz83dfmi88dgyn-jetbrains-jdk-11.0.7-b64/lib/openjdk/bin/java /opt/clion-2020.3.2/jbr/bin/java`. It's a little brittle, but not bad.

### VSCode
The only thing that vscode itself is necessary for is LiveShare. Otherwise VSCodium is fine.

In order to use the Live Share extension, it needs to be part of the VSCode derivation, I don't think it works if you just install both packages separately. There is a vscode.nix shell setup that can be used when you need Live Share or other special extensions.
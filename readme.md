# Preparing the Laptop
First, obviously, back everything up.

Then, prepare the hard drive. It’s a bit more complicated if you want to dual boot, the following will assume that it’s just booting Linux, because I don’t remember how I did it with Windows.

It’s entirely possible to do everything from the Arch image, but partitioning the hard-drive from the command-line is a pain in the ass. Make a boot USB with something like Mint, that has a nice graphical interface, and use Gparted to handle the partitions.

So, before you begin, make sure you have:
1. A second laptop, to read the docs while you're installing on the main one.
2. An ethernet connection, cause connecting to the wi-fi from the command line will waste an hour of your life that you can never get back.
3. Two USBs, one with Arch and another with something with Gparted.

I don’t do separate home and root dirs anymore. So we only need three partitions.

1. Wipe the hard-drive.
2. Create the boot partition. It _must_ be fat32. Make it between 128 and 500 MB. I'm not 100% sure what the label does, but set it to ESP, and the name to boot.
3. Make a swap partition. I can never tell if this is necessary, but just make it 4Gb. Remember to set the file-system to linux-swap. I set the name and label to swap.
4. Make the root partition. It'll be the rest of the space, and file-system is ext4. Set the name and label to rootfs.
5. After the partitions have been created, right-click on the boot partition, go to Manage Flags, and give it the `boot` and `esp` flags.

(Don't worry about the mount points. In some other distros’ graphical installs, you can partition and set up the mounts at the same time, but they'll be separate steps here.)

Now it's ready for the Arch USB.

# Installing Arch

1. Plug in the ethernet cable first. It won't pick it up if you plug it in after it's loaded.
2. Boot the freshly partitioned laptop from the Arch USB. You should get to a shell. Ping archlinux.org to make sure you're connected to the internet.
3. `blkid` to print out the partitions.
4. Mount the root partition: `mount /dev/nvme0n1p3 /mnt` (replace with whichever one is the rootfs).
5. Mount the boot partition: `mkdir /mnt/boot && mount /dev/nvme0n1p1 /mnt/boot` (replace with the boot partition).
6. Turn on the swap: `swapon /dev/nvme0n1p2`
7. Install the base package group: `pacstrap /mnt base`
8. Generate the fstab: `genfstab -U /mnt >> /mnt/etc/fstab`. I think that this basically records the mounts, so it can happen automatically on start.
9. Change root into the new system: `arch-chroot /mnt`
10. Set the time. `ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime && hwclock --systohc`.
11. Set the locales. Open /etc/locale.gen and uncomment `en_GB.UTF-8 UTF-8`. Then run `locale-gen`. Touch /etc/locale.conf and write `LANG=en_GB.UTF-8`. Load a UK keyboard with `loadkeys uk` and save it to /etc/vconsole.conf by writing `KEYMAP=uk`. That won't apply once you've started X, only the initial terminal.
12. For the networking thing, don't worry about it, you don't need to add anything for now.
13. Run `passwd` and set a root password.
14. Set up the boot loader. I'm assuming that the laptop will be UEFI. We'll skip grub, and just use EFI. Install `pacman -S efibootmgr`. Then run `efibootmgr --disk /dev/sdX --part Y --create --label "Arch Linux" --loader /vmlinuz-linux --unicode 'root=PARTUUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX rw initrd=\initramfs-linux.img' --verbose` where sdX is the disk (nvme0n1), Y is the partition number (e.g. 1 for nvme0n1p1), and the root=PARTUUID= is the root partition’s PARTUUID (not UUID) (get from blkid). If there are existing entries, you can remove them with `efibootmgr -b 0 -B`. *Don’t try to move the kernel, when you update Arch, it’ll always put the new kernel at /boot/vmlinuz-linux, and it won’t boot if it’s trying to load it from another dir.*
15. *Important*: this ain’t in the Arch docs, but it’s necessary if you want to, you know, connect to the internet. Install `pacman -S networkmanager` and then enable it with `systemctl enable NetworkManager.service`. Then it’ll still be able to connect when you restart.
16. Unmount before reboot, `exit && umount -R /mnt/boot && umount -R /mnt`. Then you can `reboot`.

If all goes well, it should boot ok. If not, double check the efi stuff.

---

# Set up Arch
## Create the user
1. Login as root.
2. Install `pacman -S sudo`
3. Create a new user `useradd -m michael`. And set a password `passwd michael`. Add them to /etc/sudoers `michael ALL=(ALL) ALL`.
4. You can then log out of root and log into the user.
5. Create the normal user dirs by installing `sudo pacman -S xdg-user-dirs`, and run `xdg-user-dirs-update`.

## Aur
Yay seems to work pretty well.
`git clone https://aur.archlinux.org/yay.git` somewhere, maybe dev/?
`cd yay`
`sudo pacman -S base-devel` compiling stuff
`makepkg -si`

From there, installing stuff is just `yay -S <package-name>`. It's a lot easier to set up than aurutils. Technically, you're supposed to review all of the builds before you install anything, but I don't, so yay is fine.

## Install a GUI (Xmonad)
1. Install X11 `sudo pacman -S xorg-server xorg-xinit xorg-xsetroot`.
2. Install a DE or WM. This is going to go with xmonad. `sudo pacman -S xmonad xmonad-contrib`.
3. Touch `.xinitrc`, which is the thing that'll run when you run `startx`. Write to it:
```
export WINIT_HIDPI_FACTOR=1.0    # keep alacritty font size consistent across resolutions
udiskie &                        # start udiskie (install it first, see below)
setxkbmap gb                     # set the keyboard layout for X
xsetroot -cursor_name left_ptr & # Fix the weird X cursor
autorandr -c                     # Set up displays _before_ setting the bar and wallpaper
feh --bg-max /path/to/bg &       # Set wallpaper
exec xmonad                      # start xmonad
```
Install `sudo pacman -S xterm`, cause that's the default for xmonad (so you can configure xmonad from within it)
4. Install the terminal that your Xmonad configuration is expecting. For alacritty it's just `sudo pacman -S alacritty`, and then copying your config to `~/.config/alacritty/alacritty.yml`.
5. Install rofi `sudo pacman -S rofi`. Then copy your config to `~/.config/rofi/config`.
6. Install polybar `yay -S polybar`. Copy the config file and launch script to `~/.config/polybar/`.
7. Then copy over your config to `~/.xmonad/xmonad.hs` and recompile it. This is assuming that the Xmonad configuration is expecting the above terminal, launcher, etc.
8. Set a background. Install `sudo pacman -S feh`, and add `feh --bg-max /home/michael/Pictures/whatever.png &` to .xinitrc.
9. Install `sudo pacman -S xsecurelock` (tried i3lock, but it was being flaky).

## Install a GUI (Sway)
1. Install `sudo pacman -S sway swaylock swayidle`. Copy the config file to `~/.config/sway/config`.

## Pacman
Some useful commands.
`sudo pacman -Syu` updates packages. This has the potentional to break stuff, so don't do it unless you have time to debug issues.
`sudo pacman -Qdt` shows unused dependencies.

## Removeable Media
This is helpful when you're loading stuff from your backup.

Probably need to install `sudo pacman -S ntfs-3g` first, to be able to read FAT32 drives. Then `sudo pacman -S udiskie`, which handles auto mounting drives. You can run `udiskie` whenever you want to mount a drive. Add `udiskie &` to your .xinitrc to start it automatically. Drives get mounting in /run/media/michael/.

## git
`sudo pacman -S git openssh meld`
Then copy your config and global ignore to `~/.gitconfig` and `~/.gitignore_global`.

To export meld settings `dconf /org/gnome/meld/ > meld.dconf`, and to import `dconf load /org/gnome/meld/ < meld.dconf`. If you're not sure what the name is, `gsettings list-schemas` will print out a list.

## Zsh (zprezto)
`sudo pacman -S zsh`
`chsh -s /bin/zsh`
`git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"`

Then copy over the config, in .zprezto/runcoms zpreztorc and zshrc, and .zprezto/modules/prompt/functions/prompt_michael_setup

## Wifi
We've already installed NetworkManager, which will handle the connections. In order to get a GUI to set up Wi-fo connections, install `sudo pacman -S nm-connection-editor`. The command to start it up is the same as the package, and it's quite easy to set up a new wifi connection. I'm not sure if you can get it to list the available SSIDs, for now I just type them in manually.

Probably best to also install `sudo pacman -S dhclient`. I needed it at one point to connect to the wi-fi at work, and though I don't know if it's strictly necessary, it's better to have installed than to try to install it without the internet.

## Music
Install `sudo pacman -S moc` and copy over the config to .moc/.

Also install the Alsa mixer `sudo pacman -S alsa-utils`, and run it with `alsamixer`. The sound always starts muted, so you need this to get it working.

If I ever figure out how mpd works, I'll put that here.

## Appearance
This is to make windows look presentable.

Install a GTK+ theme `sudo pacman -S breeze breeze-gtk` (the first one is icons and such). Then all you have to do is copy your gtk-3 config file to `~/.config/gtk-3.0/settings.ini`. There are docs online for the available settings, I've not found a GUI for changing them, you can always play with settings in a DE, and then copy the settings.

You also need to set the cursor for non-GTK apps. Do this by creating a file `~/.icons/default/index.theme` and writing
```
[icon theme]
Inherits=breeze_cursors
```
to it.

## Fonts
https://github.com/jaagr/polybar/wiki/Fonts
Update the below:
`yay -S nerd-fonts` will install a bunch of them, 'patched' with icons (which makes them good for polybar). I don't currently understand how that works. This will include Source Code Pro.

## Displays (Xmonad)
Install `sudo pacman -S xorg-xrandr` to configure displays and `yay -S autorandr` in order to save profiles, so it can switch automatically when you add/remove a monitor.

`systemctl enable autorandr` should turn it on automatically when you log in. It doesn’t seem to fire on startx, so I’ve also added it to my .xinitrc.

To save the current config `autorandr --save <setup>`, and autorandr --detected to show the available ones.

It's probably enough to know `xrandr --output HDMI-1 --mode 1920x1080 --pos 0x0`, but you can also install the package arandr to help arrange them, and then persist it with autorandr.

## Docker
I'd like to investigate rkt, but for now I need docker for work.

Install `sudo pacman -S docker`. Then `sudo groupadd docker` and `sudo usermod -aG docker $USER`. You’ll have to log in again for it to take effect.

## Utils
General things that don’t come installed, that are difficult to get by without.
`sudo pacman -S wget unzip inotify-tools`

---

## Browsers
### Firefox
`sudo pacman -S firefox`
Then go to about:config and disable service workers. Also fix the default search engine to something less evil, and update the privacy settings. And import the bookmarks.

### Brave
`yay -S brave-bin`. Fix the search engine, import bookmarks. I'm not sure if it's possible to disable serice workers, because it's based on the evil browser.

---

## Text Editors/IDEs
### Code
Install with `sudo pacman -S code`.
It's good about prompting you to install extensions for languages. There are config files for keybindings and settings to copy over to `~/.config/Code - OSS/User/`.

### Sublime
Install by downloading the tar from the website, move it to /opt and `sudo ln -s /opt/sublime_whatever/sublime_whatever /usr/local/bin`. It sometimes changes slightly, it's normally something like sublime_text. There are also instructions on the site to install it with pacman now.

Install Package Control, then
-Babel
-CloseOtherWindows
-Pretty JSON
-Theme Gravity
and others if they come up. I consistently try and fail to use ST as a code editor, but it's good for json and text editing.

Copy over the config files to `~/config/sublime-text-3/Packages/User`.

### Emacs
Not using it much, but it's good for Scheme. `sudo pacman -S emacs`, then install Doom emacs, and copy the config to ~/.doom.d/.

### Atom
Good for Idris.

## Languages
### asdf
Using asdf for anything where I need multiple versions, or the ability to use an older version.

Install `git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.1`.
Write this to your .zshrc
```
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
```

`asdf plugin-list` will list all installed plugins.
`asdf list $PLUGIN` will list installed versions.
`asdf list-all $PLUGIN` will list available versions for a plugin.
`asdf global $PLUGIN $VERSION` will set the global version for a plugin.
`asdf local $PLUGIN $VERSION` will set it for a given directory.

### Node
Install the most recent version globally `sudo pacman -S nodejs`.

Install the Node plugin `asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git` and `bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring`. This is for per-project versions, where a repo might require an older version.

VSCode has JS and TS support already, just install the Prettier extension (esbenp.prettier-vscode).

### Ruby
Install the Ruby plugin for asdf `asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git`.

To install older versions of Ruby (sigh), you need to tell it where to find openssl `PKG_CONFIG_PATH=/usr/lib/openssl-1.0/pkgconfig asdf install ruby 2.3.2`.

For VSCode, install the Ruby (rebornix.ruby) extension.

### Clojure
If using intellij, install Java 8 `sudo pacman -S jdk8-openjdk`, otherwise the more recent versions are ok `sudo pacman -S jdk-openjdk`. You’ll need to log out and log back in. Install lein by downloading the script, and putting it on your path, make it executable, and then run it.

There is a repl extension for VSCode, Calva (betterthantomorrow.calva). I've started adding key mappings for it.

### Golang
Install `sudo pacman -S go`, and set the global gopath var by adding `export GOPATH="$HOME/.go"` to your .zshrc file.

When you install the VSCode go extension it will prompt you to install all of the tools that it needs.

### Chicken Scheme
Installing Chicken is just `sudo pacman -S chicken`, although note that the
commands are prefixed with chicken-, so chicken-csi instead of csi.

Install eggs to make dev easier. They enable not only the documentation, but also auto-completion in Emacs.
```
chicken-install -s apropos chicken-doc
chicken-install -s srfi-18
cd `chicken-csi -R chicken.platform -p '(chicken-home)'`
curl https://3e8.org/pub/chicken-doc/chicken-doc-repo-5.tgz | sudo tar zx
```

The emacs config should have the necessary packages to work with it. There isn't really any Scheme integration in VSCode.

### Idris
Install `sudo pacman -S idris`.

There is a VSCode plugin for Idris, but it's buggy and un-maintained. It might just be worth using Atom for it instead, because that works fine.

### Rust
Install `sudo pacman -S rustup`.
To install rustfmt `rustup component add rustfmt --toolchain stable-x86_64-unknown-linux-gnu`.
Other tools `rustup component add rls rust-analysis rust-src`.

The Rust (rust-lang.rust) VSCode plugin is pretty good.

# imperative nixos setup
## Set user password.
The user is created in the config already. Log in as root, and run `passwd michael`. 

## Setup wifi connections
The config should install nm-connection-editor, that can be used to save wifi connections.

## Install zprezto
Just follow the instructions here: https://github.com/sorin-ionescu/prezto
It's cloning a git repo, and then running a command to generate the default config files. 

## Copy over config files
From ~/dev/config:
```
cp cursor.theme         ~/.icons/default/index.theme
cp gitconfig            ~/.gitconfig
cp gitignore_global     ~/.gitignore_global
cp gtk_settings.ini     ~/.config/gtk-3.0/settings.ini
cp i3                   ~/.config/i3/config
cp i3blocks             ~/.config/
cp kitty.conf           ~/.config/kitty/
cp moc                  ~/.moc/config
cp prompt_michael_setup ~/.zprezto/modules/prompt/functions/
cp rofi_config          ~/.config/rofi/config
cp xinitrc_i3           ~/.xinitrc
cp zshrc                ~/.zprezto/runcoms/
cp zpreztorc            ~/.zprezto/runcoms/
```

## Meld
TODO

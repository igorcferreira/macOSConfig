# Set of Mac OS configuration

This repo works as a container of tools that can be used to setup a macOS instance

## Run all the install scripts (minus dot files)

To run this script, just execute:

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/igorcferreira/macOSConfig/master/install.sh)"
```

This script may ask input at some point, but, at the end, all will be whell

## Run specific scripts

You can run install scripts individually with, for example:

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/igorcferreira/macOSConfig/master/install_homebrew.sh)"
```

Keep in mind that certain install scripts expects some dependencies already installed. For example, `install_java` expects Homebrew to be installed

## Link dot files

If you wish to have a copy of my dot files configuration, you can close this repository and run:

```sh
./install_dot_files.sh
```
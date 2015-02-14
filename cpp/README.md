# SDDM Configuration Editor - C++ version

## Dependencies

- [Qt](http://qt-project.org/)
- [PolKit](http://www.freedesktop.org/wiki/Software/polkit/) (for the Save button)

## Building

    qmake
    make

Optionally, pass `PREFIX=<path>` as an argument to qmake to set the install prefix,
and use `make install` to install.

An install script for Arch Linux is provided
[in AUR](https://aur.archlinux.org/packages/sddm-config-editor-git/).

See the [general README.md](/README.md) for other information.

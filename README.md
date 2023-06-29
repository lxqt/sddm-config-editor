# sddm-config-editor

Out of support and replaced by [sddm-conf](https://github.com/redtide/sddm-conf).

## Description

This is to be a graphical editor for [Simple Desktop Display
Manager](https://github.com/sddm/sddm)'s configuration file. It is in
early alpha.

There is a [Ruby](ruby) version and a [C++](cpp) version of this program.
They (should) have the same functionality. See their respective README.md
for specific information.

## License

Apache 2.0

## Usage

Run `sddm-configuration-editor`.

The program displays available settings with current values in its
GUI. Gray (placeholder) text and gray checkboxes indicate default
values. There are buttons to load settings from the system configuration
file, and save settings to it.

![screenshot](http://i.imgur.com/7B67Orm.png)

## Features / TODO

- [x] Display descriptions and default values of settings from
  `sddm --example-config` output
- [x] Display settings in system configuration file
- [x] Generate configuration file from settings in the GUI
- [x] Save generated configuration file to the system
- [x] Handle string, boolean and integer setting types
- [x] Handle enum setting types
- [x] Launch theme preview
- [ ] Validate configuration file
- [x] Automatically generate configuration file when GUI settings change
- [x] Provide install scripts
- [x] Localization



 
## Translations

Translations can be done in [LXQt-Weblate](https://translate.lxqt-project.org/projects/lxqt-configuration/sddm-config-editor/).

<a href="https://translate.lxqt-project.org/projects/lxqt-configuration/sddm-config-editor/">
<img src="https://translate.lxqt-project.org/widgets/lxqt-configuration/-/sddm-config-editor/multi-auto.svg" alt="Translation status" />
</a>

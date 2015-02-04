# sddm-config-editor

SDDM Configuration Editor

## Description

This is to be a graphical editor for [Simple Desktop Display Manager](https://github.com/sddm/sddm)'s configuration file. It is in early alpha.

## Dependencies

This program requires

* [Ruby 2](https://www.ruby-lang.org)
* [QML-Ruby](http://seanchas116.github.io/ruby-qml/)
* [Parslet](http://kschiess.github.io/parslet/)

## Usage

Run `sddm-configuration-editor`.

The program displays available settings with current values in its GUI. Gray (placeholder) text and partially checked checkboxes indicate default values. There are buttons to generate a new configuration file from the values set in the GUI, load settings from the system configuration file, and save settings to it.

![screenshot](http://i.imgur.com/9f1T3K4.png)

## Features / TODO

- [x] Display descriptions and default values of settings from `sddm --example-config` output
- [x] Display settings in system configuration file
- [x] Generate configuration file from settings in the GUI
- [x] Save generated configuration file to the system
- [x] Handle string and boolean setting types
- [ ] Handle enum setting types
- [ ] Launch theme preview
- [ ] Validate configuration file
- [ ] Automatically generate configuration file when GUI settings change
- [ ] Automatically parse when configuration file in text area is edited
- [ ] Provide install scripts

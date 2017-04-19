#!/bin/sh

if which sddm > /dev/null
then
  sddm --example-config > ../data/example.conf
  ../ruby/make-config-schema
  lupdate config-strings.qml -ts *.ts
fi

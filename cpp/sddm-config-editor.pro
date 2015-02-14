TEMPLATE = app

CONFIG += debug
QT += qml quick widgets

SOURCES += main.cpp controller.cpp configuration.cpp section.cpp setting.cpp
HEADERS += controller.h configuration.h section.h setting.h

RESOURCES += qml.qrc

target.path = /usr/bin/

desktop_file.path = /usr/share/applications/
desktop_file.files = data/sddm-config-editor.desktop

INSTALLS += desktop_file target


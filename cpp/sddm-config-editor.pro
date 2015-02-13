TEMPLATE = app

CONFIG += debug
QT += qml quick widgets

SOURCES += main.cpp controller.cpp configuration.cpp section.cpp setting.cpp
HEADERS += controller.h configuration.h section.h setting.h

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

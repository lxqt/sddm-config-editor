TEMPLATE = app

CONFIG += debug
QT += qml quick widgets

SOURCES += main.cpp controller.cpp configuration.cpp section.cpp setting.cpp
HEADERS += controller.h configuration.h section.h setting.h

lupdate_only {
  SOURCES += ui/*.qml config-strings.qml
}
TRANSLATIONS = sddm-config-editor_cs.ts \
               sddm-config-editor_de.ts \
               sddm-config-editor_es.ts \
               sddm-config-editor_fr.ts \
               sddm-config-editor_hr.ts \
               sddm-config-editor_it.ts \
               sddm-config-editor_ja.ts \
               sddm-config-editor_nl.ts \
               sddm-config-editor_pl.ts \
               sddm-config-editor_pt.ts \
               sddm-config-editor_ru.ts \
               sddm-config-editor_zh_CN.ts
QMAKE_EXTRA_COMPILERS += lrelease
lrelease.input         = TRANSLATIONS
lrelease.output        = ${QMAKE_FILE_BASE}.qm
lrelease.commands      = $$[QT_INSTALL_BINS]/lrelease ${QMAKE_FILE_IN} -qm ${QMAKE_FILE_BASE}.qm
lrelease.CONFIG       += ignore_no_exist no_link
PRE_TARGETDEPS += compiler_lrelease_make_all
system(lrelease sddm-config-editor.pro)

RESOURCES += qml.qrc \
             translations.qrc

target.path = "$$PREFIX/usr/bin/"

desktop_file.path = "$$PREFIX/usr/share/applications/"
desktop_file.files = data/sddm-config-editor.desktop

INSTALLS += desktop_file target


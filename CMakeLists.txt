project(sddm-config-editor)
cmake_minimum_required(VERSION 3.0.2 FATAL_ERROR)
set(LXQTBT_MINIMUM_VERSION "0.5.0")

option(UPDATE_TRANSLATIONS "Update source translation translations/*.ts files" OFF)

find_package(lxqt-build-tools ${LXQTBT_MINIMUM_VERSION} REQUIRED)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()



#include(LXQtPreventInSourceBuilds)
include(LXQtConfigVars)
include(LXQtTranslateTs)
include(LXQtTranslateDesktop)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt5Gui REQUIRED)
find_package(Qt5Widgets REQUIRED)
find_package(Qt5X11Extras REQUIRED)
find_package(Qt5LinguistTools REQUIRED)
find_package(X11 REQUIRED)
include(GNUInstallDirs REQUIRED)
include(LXQtCompilerSettings NO_POLICY_SCOPE)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DQT_NO_KEYWORDS")

set(QTX_INCLUDE_DIRS "")
set(QTX_LIBRARIES Qt5:Core Qt5:Gui Qt5::Widgets Qt5::DBus)


set(CPP_FILES
    src/configuration.cpp
    src/controller.cpp
    src/section.cpp
    src/setting.cpp
    src/configuration.h
    src/controller.h
    src/section.h
    src/setting.h
    main.cpp
)


set(UI_FILES
    ui/boolean-editor.qml
    ui/directory-editor.qml
    ui/enum-editor.qml
    ui/file-editor.qml
    ui/integer-editor.qml
    ui/main-window.qml
    ui/numlock-editor.qml
    ui/path_list-editor.qml
    ui/session-editor.qml
    ui/setting-section.qml
    ui/string-editor.qml
    ui/theme-editor.qml
)





# lxqt_translate_ts(QM_FILES
#     UPDATE_TRANSLATIONS ${UPDATE_TRANSLATIONS}
#     SOURCES
#         ${H_FILES}
#         ${CPP_FILES}
#         ${UI_FILES}
#     INSTALL_DIR
#         "${LXQT_TRANSLATIONS_DIR}/${PROJECT_NAME}"
# )


# lxqt_translate_desktop(DESKTOP_FILES
#     SOURCES
#     resources/lxqt-about.desktop.in
# )
#************************************************

# include(translatorsinfo/CMakeLists.txt)
# get_translatorsinfo_qrc(translatorsinfo_qrc)

add_executable(${PROJECT_NAME}
    ${CPP_FILES}
)


target_link_libraries(${PROJECT_NAME}
    lxqt
)

install(TARGETS
    ${PROJECT_NAME}
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
    COMPONENT Runtime
)

#install(FILES
#    ${DESKTOP_FILES}
#    DESTINATION "${CMAKE_INSTALL_DATAROOTDIR}/applications"
#    COMPONENT Runtime
#)

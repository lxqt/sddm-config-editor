cmake_minimum_required(VERSION 3.2.0)

project(sddm-config-editor)

#
# Qt5 support
#
# general overview:
#  * [Modern CMake with Qt and Boost](http://www.kdab.com/modern-cmake-with-qt-and-boost/)
#  * [Using CMake with Qt 5](http://www.kdab.com/using-cmake-with-qt-5/)
#
set(CMAKE_AUTOMOC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt5Widgets REQUIRED)
find_package(Qt5Qml REQUIRED)
find_package(Qt5Quick REQUIRED)
find_package(lxqt-build-tools REQUIRED)


if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

# include(LXQtPreventInSourceBuilds)
include(LXQtTranslateTs)
include(LXQtTranslateDesktop)
#include(LXQtCompilerSettings)
# include(LXQtCompilerSettings NO_POLICY_SCOPE)



set(QT5_LIBRARIES Qt5::Widgets Qt5::Qml Qt5::Quick)

#
# project main
#
set(TARGET ${CMAKE_PROJECT_NAME})

set(SOURCES
    main.cpp
    src/section.cpp
    src/section.h
    src/configuration.cpp
    src/configuration.h
    src/controller.cpp
    src/controller.h
    src/setting.cpp
    src/setting.h
)


qt5_add_resources(QT_RESOURCES ui/qml.qrc)

#
# Generate necessary headers from .ui files. (qmake lets `uic` do this job.)
# hint from [Cross-platform Qt5 project using cmake](http://stackoverflow.com/questions/21174586/cross-platform-qt5-project-using-cmake)
#
# qt5_wrap_ui(UI_GENERATED_HEADERS ${UI_SOURCES})
#
# IMPORTANT: Adding generated headers to target as dependencies
# hint from [unable to include a ui_form header of QT5 in cmake](http://stackoverflow.com/questions/16245147/unable-to-include-a-ui-form-header-of-qt5-in-cmake)
#


add_subdirectory(ui)
add_executable(${TARGET} ${SOURCES} ${UI_GENERATED_HEADERS} ${QT_RESOURCES})

#
# `target_link_libraries()` rather than `qt5_use_modules()` for CMake 2.8.11 or later
# hint from [CMake & QT5 - QT5_WRAP_UI not generating ui header files](http://stackoverflow.com/questions/25875255/cmake-qt5-qt5-wrap-ui-not-generating-ui-header-files)
#
target_link_libraries(${TARGET}
    Qt5::Widgets
    Qt5::Qml
    Qt5::Quick
)


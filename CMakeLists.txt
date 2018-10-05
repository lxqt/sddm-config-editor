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
# include(LXQtTranslateDesktop)
# include(LXQtCompilerSettings)
# include(LXQtCompilerSettings NO_POLICY_SCOPE)


set(QT5_LIBRARIES Qt5::Widgets Qt5::Qml Qt5::Quick)

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

qt5_add_resources(QT_RESOURCES qml.qrc)

add_executable(${TARGET} ${SOURCES} ${QT_RESOURCES})

target_link_libraries(${TARGET}
    Qt5::Widgets
    Qt5::Qml
    Qt5::Quick
)


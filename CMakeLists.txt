cmake_minimum_required(VERSION 3.1.0 FATAL_ERROR)
# CMP0000: Call the cmake_minimum_required() command at the beginning of the top-level
# CMakeLists.txt file even before calling the project() command.
# The cmake_minimum_required(VERSION) command implicitly invokes the cmake_policy(VERSION)
# command to specify that the current project code is written for the given range of CMake
# versions.
project(SDDMConfigEditor)

include(GNUInstallDirs)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

find_package(Qt5 COMPONENTS Qml Quick Widgets LinguistTools REQUIRED)

set(SRC
    cpp/configuration.cpp
    cpp/controller.cpp
    cpp/main.cpp
    cpp/section.cpp
    cpp/setting.cpp
)

set(RCC cpp/qml.qrc)

file(GLOB TS cpp/sddm-config-editor_*.ts)

set_directory_properties(PROPERTIES CLEAN_NO_CUSTOM true)

qt5_add_translation(TRANSLATIONS ${TS})

add_executable(sddm-config-editor ${SRC} ${RCC} ${TRANSLATIONS})
target_link_libraries(sddm-config-editor Qt5::Qml Qt5::Quick Qt5::Widgets)

install(
    FILES data/sddm-config-editor.desktop
    DESTINATION "${CMAKE_INSTALL_DATADIR}/applications"
)

install(TARGETS sddm-config-editor RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}")

install(
    FILES ${TRANSLATIONS}
    DESTINATION "${CMAKE_INSTALL_DATADIR}/sddm-config-editor/translations"
)
add_definitions(
    -DTRANSLATION_DIR="${CMAKE_INSTALL_FULL_DATADIR}/sddm-config-editor/translations"
)

# uninstall target
if(NOT TARGET uninstall)
    configure_file(
        "${CMAKE_CURRENT_SOURCE_DIR}/cmake_uninstall.cmake.in"
        "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
        IMMEDIATE @ONLY)

        add_custom_target(uninstall
            COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake)
endif()

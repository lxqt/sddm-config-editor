#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "controller.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<Controller>("SDDMConfigurationEditor", 0, 1,
                                "ConfigEditorController");
    qmlRegisterUncreatableType<Configuration>("SDDMConfigurationEditor", 0, 1,
                              "Configuration", "Do not create");
    qmlRegisterUncreatableType<Section>("SDDMConfigurationEditor", 0, 1,
                             "Section", "Do not create");
    qmlRegisterUncreatableType<Setting>("SDDMConfigurationEditor", 0, 1,
                             "Setting", "Do not create");
    engine.load(QUrl(QStringLiteral("qrc:/ui/main-window.qml")));

    return app.exec();
}

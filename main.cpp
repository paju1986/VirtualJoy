#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "virtualjoystick.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    VirtualJoystick vjoy;

    engine.rootContext()->setContextProperty("joystick", &vjoy);
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}

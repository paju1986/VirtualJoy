#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickWindow>
#include <QStandardPaths>
#include <QFile>
#include <QDir>
#include <QFileInfo>
#include <QDebug>

#include "virtualjoystick.h"


void ensureConfigFileExists() {
    QString configFileName = "VirtualJoy.conf";

    // Where we want to store the user configuration
    QDir dir(QStandardPaths::writableLocation(QStandardPaths::ConfigLocation));
    QString configPath = dir.absolutePath();

    qDebug() << "Config path:" << configPath;
    QDir().mkpath(configPath); // Ensure the directory exists
    QString fullConfigFilePath = configPath + "/VirtualJoy/" + configFileName;

    // Path to default config file inside your application folder
    QString defaultConfigPath = QCoreApplication::applicationDirPath() + "/" + configFileName;

    if (!QFile::exists(fullConfigFilePath)) {
        QFile::copy(defaultConfigPath, fullConfigFilePath);
    }
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QCoreApplication::setOrganizationName("VirtualJoy");

    ensureConfigFileExists();

    QCoreApplication::setApplicationName("VirtualJoy");

    QQmlApplicationEngine engine;
    VirtualJoystick vjoy;

    engine.rootContext()->setContextProperty("joystick", &vjoy);
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
            QQuickWindow *window = qobject_cast<QQuickWindow *>(obj);
        if (window) {
            window->setColor(Qt::transparent);  // Transparent background
        }
        }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}

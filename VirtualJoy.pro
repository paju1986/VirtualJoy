QT += quick gui
CONFIG += c++17

TARGET = virtualjoy
TEMPLATE = app

SOURCES += \
    main.cpp \
    virtualjoystick.cpp

HEADERS += \
    virtualjoystick.h

RESOURCES += \
    qml.qrc

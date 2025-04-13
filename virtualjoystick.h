// virtualjoystick.h
#ifndef VIRTUALJOYSTICK_H
#define VIRTUALJOYSTICK_H

#include <QObject>
#include <linux/uinput.h>

class VirtualJoystick : public QObject
{
    Q_OBJECT
public:
    explicit VirtualJoystick(QObject *parent = nullptr);
    ~VirtualJoystick();

    Q_INVOKABLE void moveAxis(int x, int y);

private:
    int uinput_fd;
    void emit_event(uint16_t type, uint16_t code, int32_t value);
};

#endif // VIRTUALJOYSTICK_H

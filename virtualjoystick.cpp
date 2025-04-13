// virtualjoystick.cpp
#include "virtualjoystick.h"
#include <fcntl.h>
#include <unistd.h>
#include <cstring>
#include <iostream>
#include <QDebug>


VirtualJoystick::VirtualJoystick(QObject *parent) : QObject(parent) {
   uinput_fd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
    if(uinput_fd < 0) {
        perror("open");
    }

    ioctl(uinput_fd, UI_SET_EVBIT, EV_ABS);
    ioctl(uinput_fd, UI_SET_ABSBIT, ABS_X);
    ioctl(uinput_fd, UI_SET_ABSBIT, ABS_Y);
    ioctl(uinput_fd, UI_SET_ABSBIT, ABS_RX);
    ioctl(uinput_fd, UI_SET_ABSBIT, ABS_RY);
    ioctl(uinput_fd, UI_SET_EVBIT, EV_KEY);
    ioctl(uinput_fd, UI_SET_EVBIT, EV_SYN);

    ioctl(uinput_fd, UI_SET_KEYBIT, BTN_A);
    ioctl(uinput_fd, UI_SET_KEYBIT, BTN_B);
    ioctl(uinput_fd, UI_SET_KEYBIT, BTN_X);
    ioctl(uinput_fd, UI_SET_KEYBIT, BTN_Y);
    ioctl(uinput_fd, UI_SET_KEYBIT, BTN_START);
    ioctl(uinput_fd, UI_SET_KEYBIT, BTN_SELECT);
    ioctl(uinput_fd, UI_SET_KEYBIT, BTN_DPAD_UP);
    ioctl(uinput_fd, UI_SET_KEYBIT, BTN_DPAD_DOWN);
    ioctl(uinput_fd, UI_SET_KEYBIT, BTN_DPAD_LEFT);
    ioctl(uinput_fd, UI_SET_KEYBIT, BTN_DPAD_RIGHT);

    struct uinput_user_dev uidev;
    memset(&uidev, 0, sizeof(uidev));
    snprintf(uidev.name, UINPUT_MAX_NAME_SIZE, "Virtual Gamepad");
    uidev.id.bustype = BUS_USB;
    uidev.id.vendor  = 0x1234;
    uidev.id.product = 0x5678;
    uidev.id.version = 1;

    // Define axis range
    uidev.absmin[ABS_X] = -32767;
    uidev.absmax[ABS_X] = 32767;
    uidev.absflat[ABS_X] = 15;
    uidev.absmin[ABS_Y] = -32767;
    uidev.absmax[ABS_Y] = 32767;
    uidev.absflat[ABS_X] = 15;

    uidev.absmin[ABS_RX] = -32767;
    uidev.absmax[ABS_RX] = 32767;
    uidev.absflat[ABS_RX] = 15;
    uidev.absmin[ABS_RY] = -32767;
    uidev.absmax[ABS_RY] = 32767;
    uidev.absflat[ABS_RX] = 15;

    write(uinput_fd, &uidev, sizeof(uidev));
    ioctl(uinput_fd, UI_DEV_CREATE);
    sleep(1);

}


VirtualJoystick::~VirtualJoystick() {
    if (uinput_fd >= 0) {
        ioctl(uinput_fd, UI_DEV_DESTROY);
        close(uinput_fd);
    }
}

void VirtualJoystick::emit_event(uint16_t type, uint16_t code, int32_t value) {
    struct input_event ev{};
    ev.type = type;
    ev.code = code;
    ev.value = value;
    ev.time.tv_sec = 0;
    ev.time.tv_usec = 0;
    write(uinput_fd, &ev, sizeof(ev));
}

void VirtualJoystick::moveAxisXY(int x, int y) {
    emit_event(EV_ABS, ABS_X, x);
    emit_event(EV_SYN, SYN_REPORT, 0);
    emit_event(EV_ABS, ABS_Y, y);
    emit_event(EV_SYN, SYN_REPORT, 0);

}

void VirtualJoystick::moveAxisRXY(int x, int y) {
    emit_event(EV_ABS, ABS_RX, x);
    emit_event(EV_SYN, SYN_REPORT, 0);
    emit_event(EV_ABS, ABS_RY, y);
    emit_event(EV_SYN, SYN_REPORT, 0);

}

void VirtualJoystick::button(int code, int value) {
    emit_event(EV_KEY, code, value);
    emit_event(EV_SYN, SYN_REPORT, 0);
}

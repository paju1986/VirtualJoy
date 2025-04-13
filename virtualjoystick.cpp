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
    ioctl(uinput_fd, UI_SET_EVBIT, EV_KEY);
    ioctl(uinput_fd, UI_SET_KEYBIT, BTN_A);
    ioctl(uinput_fd, UI_SET_KEYBIT, BTN_B);
    ioctl(uinput_fd, UI_SET_EVBIT, EV_SYN);

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

    write(uinput_fd, &uidev, sizeof(uidev));
    sleep(1);
    ioctl(uinput_fd, UI_DEV_CREATE);

    sleep(1);

    // Simulate button A press
    struct input_event ev;
    memset(&ev, 0, sizeof(ev));
    ev.type = EV_KEY;
    ev.code = BTN_A;
    ev.value = 1;
    write(uinput_fd, &ev, sizeof(ev));

    // Syn event
    ev.type = EV_SYN;
    ev.code = SYN_REPORT;
    ev.value = 0;
    write(uinput_fd, &ev, sizeof(ev));

    sleep(1);

    // Button release
    ev.type = EV_KEY;
    ev.code = BTN_A;
    ev.value = 0;
    write(uinput_fd, &ev, sizeof(ev));

    ev.type = EV_SYN;
    ev.code = SYN_REPORT;
    ev.value = 0;
    write(uinput_fd, &ev, sizeof(ev));

    sleep(1);

    std::cout << "Moving joystick to (10000, -10000)..." << std::endl;
    emit_event(EV_ABS, ABS_X, 10000);
    emit_event(EV_ABS, ABS_Y, -10000);
    emit_event(EV_SYN, SYN_REPORT, 0);
    sleep(5);

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

void VirtualJoystick::moveAxis(int x, int y) {
    emit_event(EV_ABS, ABS_X, x);
    emit_event(EV_SYN, SYN_REPORT, 0);
    emit_event(EV_ABS, ABS_Y, y);
    emit_event(EV_SYN, SYN_REPORT, 0);

}

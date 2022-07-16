#pragma once

#include <robot/robot.h>
#include <memory>

namespace Robot
{
    class Controller
    {
    public:
        Controller();

        std::unique_ptr<Robot> robot;
        uint16_t motion_time = 0;   // Ticks counter
        float dt = 0.002;           // One tick duration

        void control();             // One tick strategy
    };
}

#pragma once

#include <memory>

#include <robot/robot.h>
#include <robot/program.h>

namespace Robot
{
    class Controller
    {
        UNITREE_LEGGED_SDK::LoopFunc *loop_udbSend;
        UNITREE_LEGGED_SDK::LoopFunc *loop_udpResv;
        UNITREE_LEGGED_SDK::LoopFunc *loop_control;
    public:
        Controller();

        std::unique_ptr<Robot> robot;
        uint16_t motion_time = 0;           // Ticks counter
        float dt = 0.002;                   // One tick duration
        std::unique_ptr<Program> program = nullptr;   // Current executing program

        void control();             // One tick strategy
    };
}

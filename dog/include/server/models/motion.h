#pragma once

#include <vector>
#include <stdint.h>
#include <drogon/drogon.h>

namespace Server
{
    struct Motion
    {
        // General information
        uint8_t leg;            // Leg number
        uint16_t start_time;    // Tick when motion will be activated
        uint16_t duration;      // Number of ticks motion will be executing
        uint16_t sleep_time;    // Number of ticks after motion when robot will be doing nothing

        // Motor state information
        float q;                // Angle (rad)
        float dq;               // Velocity (rad/sec)
        float tau;              // Desired output torque (N.m)
        float Kp;               // Position stiffness (N.m / rad)
        float Kd;               // Velocity stiffness (N.m / (rad / sec))
    };
}

namespace drogon
{
    template<>
    std::vector<Server::Motion> fromRequest(const drogon::HttpRequest &req);
}

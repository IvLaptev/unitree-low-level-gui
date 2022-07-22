#pragma once

#include <stdint.h>
#include <string>
#include <memory>
#include <json/json.h>

namespace Server 
{
    struct Log
    {
        // General
        uint8_t leg;
        int tick;
        int motion_number;
        std::string mode;

        // Cmd
        float cmd_q;
        float cmd_dq;
        float cmd_tau;
        float cmd_kp;
        float cmd_kd;

        // State
        float state_q;
        float state_dq;
        float state_ddq;
        float state_tau;
    };

    Json::Value toJson(Log item);
}

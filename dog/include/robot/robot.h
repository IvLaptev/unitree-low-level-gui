#pragma once

#include <unitree_legged_sdk/unitree_legged_sdk.h>

namespace Robot
{
    class Robot
    {
    public:
        UNITREE_LEGGED_SDK::Safety safe;
        UNITREE_LEGGED_SDK::UDP udp;
        UNITREE_LEGGED_SDK::LowCmd cmd = {0};
        UNITREE_LEGGED_SDK::LowState state = {0};

        Robot(uint8_t level) : safe(UNITREE_LEGGED_SDK::LeggedType::A1), udp(8001, (char*)"192.168.1.42", 8000, 1024, 1024)
        {
            udp.targetIP =      (char*)"192.168.1.42";
            udp.targetPort =    8000;
            udp.InitCmdData(cmd);
        }

        void UDPRecv();

        void UDPSend();

        void setCmd();

        UNITREE_LEGGED_SDK::LowState* getState();
    };
}

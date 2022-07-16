#include <robot/robot.h>

void Robot::Robot::UDPRecv()
{
    udp.Recv();
}

void Robot::Robot::UDPSend()
{
    udp.Send();
}

void Robot::Robot::setCmd()
{
    udp.SetSend(cmd);
}

UNITREE_LEGGED_SDK::LowState* Robot::Robot::getState()
{
    udp.GetRecv(state);
    return &state;
}

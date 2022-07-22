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

Server::Log Server::logFromObjects(uint8_t leg, int tick, int motion_number, const UNITREE_LEGGED_SDK::MotorCmd &cmd, const UNITREE_LEGGED_SDK::MotorState &state)
{
    
    Server::Log log = {};

    log.tick = tick;
    log.leg = leg;
    log.motion_number = motion_number;
    log.mode = "";

    log.cmd_q = cmd.q;
    log.cmd_dq = cmd.dq;
    log.cmd_tau = cmd.tau;
    log.cmd_kp = cmd.Kp;
    log.cmd_kd = cmd.Kd;

    log.state_q = state.q;
    log.state_dq = state.dq;
    log.state_ddq = state.ddq;
    log.state_tau = state.tauEst;

    return log;
}

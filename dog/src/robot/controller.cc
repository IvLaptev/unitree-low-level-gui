#include <robot/controller.h>

Robot::Controller::Controller()
{
    robot = std::unique_ptr<Robot>(new Robot(UNITREE_LEGGED_SDK::LOWLEVEL));

    UNITREE_LEGGED_SDK::InitEnvironment();

    // Setting udp message every dt
    UNITREE_LEGGED_SDK::LoopFunc loop_udbSend("udp_send", dt, boost::bind(&Robot::UDPSend, robot.get()));
    // Getting robot feedback every dt
    UNITREE_LEGGED_SDK::LoopFunc loop_udpResv("udp_recv", dt, boost::bind(&Robot::UDPRecv, robot.get()));
    // Counting next control command every dt
    UNITREE_LEGGED_SDK::LoopFunc loop_control("control",  dt, boost::bind(&Controller::control, this));

    loop_udpResv.start();
    loop_udbSend.start();
    loop_control.start();
}

void Robot::Controller::control()
{
    motion_time += 1;
    
    std::unique_ptr<UNITREE_LEGGED_SDK::LowState> state(robot->getState());
    
    // Body of strategy

    robot->setCmd();
}

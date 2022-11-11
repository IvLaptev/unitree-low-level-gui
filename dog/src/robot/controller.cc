#include <robot/controller.h>
#include <server/store.h>

#include <iostream>

Robot::Controller::Controller()
{
    // Creating connection with robot. Setting control to low
    robot = std::unique_ptr<Robot>(new Robot(UNITREE_LEGGED_SDK::LOWLEVEL));

    UNITREE_LEGGED_SDK::InitEnvironment();

    // Setting udp message every dt
    loop_udbSend = new UNITREE_LEGGED_SDK::LoopFunc("udp_send", dt, boost::bind(&Robot::UDPSend, robot.get()));
    // Getting robot feedback every dt
    loop_udpResv = new UNITREE_LEGGED_SDK::LoopFunc("udp_recv", dt, boost::bind(&Robot::UDPRecv, robot.get()));
    // Counting next control command every dt
    loop_control = new UNITREE_LEGGED_SDK::LoopFunc("control",  dt, boost::bind(&Controller::control, this));

    // loop_udpResv->start();
    loop_udbSend->start();
    loop_control->start();
}

void Robot::Controller::load_program()
{
    if (motion_time % 500 == 0 && program == nullptr)
    {
        std::cout << "Get program" << std::endl;

        std::vector<Server::Motion> motions = Server::Store::getData().getMotions();
        if (motions.size() != 0)
        {
            program = std::unique_ptr<Program>(new Program(motions));
            if (program)
            {
                Server::Store::getData().createNewLogsGroup();
                std::cout << "Loaded" << std::endl;
            }
            
        // std::cout << (*(program->legs_commands[0][159])).duration << std::endl;
        }
    }
}

void Robot::Controller::control()
{
    // std::cout << "1" << std::endl;
    load_program();
    // if (program)
    // {
    //     std::cout  << std::endl;
    //     std::cout << program->legs_commands[0][159] << std::endl;
    // }

    // std::unique_ptr<UNITREE_LEGGED_SDK::LowState> state(robot->getState());

    if (program)
    {
        program->next_tick(robot->state, robot->cmd);

        if (program->is_finished())
        {
            program = nullptr;
            Server::Store::getData().nextMotion();
        }
    }

    robot->setCmd();
    motion_time += 1;
}

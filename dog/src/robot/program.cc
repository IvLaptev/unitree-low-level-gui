#include <robot/program.h>
#include <server/store.h>
#include <iostream>

unsigned get_max_ticks(const std::vector<Server::Motion> &motions)
{
    unsigned max_ticks = 0;
    for (auto& motion : motions)
    {
        if (max_ticks < motion.start_time + motion.duration)
        {
            max_ticks = motion.start_time + motion.duration;
        }
    }

    return max_ticks;
}

Robot::Program::Program(std::vector<Server::Motion> &motions)
{
    // Adds 100 ticks: 50 before start and 50 after finish
    max_ticks = get_max_ticks(motions) + 100;

    // Creating a vector for each leg where there will be assigned one motion for every tick
    legs_commands.resize(12);
    for (int i = 0; i < 12; i++)
    {
        legs_commands[i].resize(max_ticks, -1);
    }

    for (int i = 0; i < motions.size(); i++)
    {
        motions[i].start_time = 50 + motions[i].start_time;
        for (int j = 0; j < motions[i].duration; j++)
        {
            legs_commands[motions[i].leg][motions[i].start_time + j] = i;
        }
    }

    // for (unsigned i = 0; i < max_ticks; i++) 
    // {
    //     if (legs_commands[0][i] != nullptr)
    //     {
    //         if (legs_commands[0][i - 1] == nullptr)
    //         {
    //             legs_commands[0][i]->dq = 100;
    //         }
    //         std::cout << i << " " << legs_commands[0][i]->start_time << std::endl;
    //     }
    //     else
    //     {
    //         std::cout << " N";
    //     }
    // }
}

void Robot::Program::next_tick(const UNITREE_LEGGED_SDK::LowState &state, UNITREE_LEGGED_SDK::LowCmd &cmd)
{
    auto motions = Server::Store::getData().getMotions();

    for (short i = 0; i < 12; i++)
    {
        int motion_index = legs_commands[i][curr_tick];
        auto motion = motions[motion_index];

        if (motion_index > -1)
        {
            int ticks_left = motion.start_time + motion.duration - curr_tick;
            if (ticks_left > 0)
            {
                float q_step = (motion.q - state.motorState[i].q) / ticks_left;

                cmd.motorCmd[i].q = state.motorState[i].q + q_step;
            }
            else
            {
                cmd.motorCmd[i].q = motion.q;
            }

            cmd.motorCmd[i].mode = 0x0A;
            cmd.motorCmd[i].dq = 0;
            cmd.motorCmd[i].tau = 0;

            cmd.motorCmd[i].Kp = motion.Kp;
            cmd.motorCmd[i].Kd = motion.Kd;
        }
    }
    curr_tick += 1;
}

bool Robot::Program::is_finished()
{
    return curr_tick >= max_ticks;
}

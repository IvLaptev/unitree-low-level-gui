#include <robot/program.h>
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
        legs_commands[i].resize(max_ticks);
    }

    for (int i = 0; i < motions.size(); i++)
    {
        motions[i].start_time = 50 + motions[i].start_time;
        for (int j = 0; j < motions[i].duration; j++)
        {
            legs_commands[motions[i].leg][motions[i].start_time + j] = &(motions[i]);
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

void Robot::Program::next_tick()
{
    
}

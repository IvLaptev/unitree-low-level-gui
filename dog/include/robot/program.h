#pragma once

#include <vector>
#include <server/models/motion.h>
#include <unitree_legged_sdk/unitree_legged_sdk.h>

namespace Robot
{
    class Program
    {
        std::vector< std::vector< Server::Motion *> > legs_commands;
    public:
        unsigned max_ticks;

        Program(std::vector<Server::Motion> &);

        void next_tick();
    };
}

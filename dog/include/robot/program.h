#pragma once

#include <vector>
#include <server/models/motion.h>
#include <unitree_legged_sdk/unitree_legged_sdk.h>

namespace Robot
{
    class Program
    {
        unsigned max_ticks;
        std::vector< std::vector< Server::Motion *> > legs_commands;
    public:
        Program(std::vector<Server::Motion> &);
    };
}

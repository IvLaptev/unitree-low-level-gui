#pragma once

#include <vector>
#include <server/models/motion.h>
#include <unitree_legged_sdk/unitree_legged_sdk.h>

namespace Robot
{
    class Program
    {
        unsigned max_ticks;
        unsigned curr_tick = 0;
    public:
        std::vector< std::vector< int > > legs_commands;
        Program(std::vector<Server::Motion> &);

        void next_tick(const UNITREE_LEGGED_SDK::LowState &, UNITREE_LEGGED_SDK::LowCmd &);

        bool is_finished();
    };
}

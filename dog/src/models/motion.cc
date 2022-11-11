#include <vector>

#include <drogon/drogon.h>
#include <server/models/motion.h>
#include <iostream>

namespace drogon
{
    template<>
    std::vector<Server::Motion> fromRequest(const drogon::HttpRequest &req)
    { 
        std::vector<Server::Motion> motions = {};
        auto json = req.getJsonObject();

        for (auto json_part : (*json))
        {
            Server::Motion motion;

            motion.leg = json_part["leg"].asUInt();
            motion.start_time = json_part["start_time"].asUInt() + 50;
            motion.duration = json_part["duration"].asUInt();
            motion.sleep_time = json_part["sleep_time"].asUInt();
            
            motion.q = json_part["q"].asFloat();
            motion.dq = json_part["dq"].asFloat();
            motion.tau = json_part["tau"].asFloat();
            motion.Kp = json_part["kp"].asFloat();
            motion.Kd = json_part["kd"].asFloat();

            motions.push_back(motion);
        }
        // std::cout << (*json) << std::endl;

        return motions;
    }
}

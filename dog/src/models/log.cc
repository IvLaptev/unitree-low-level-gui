#include <server/models/log.h>

namespace Server
{
    Json::Value toJson(Log item)
    {
        Json::Value e;

        e["leg"] = item.leg;
        e["tick"] = item.tick;
        e["motion_number"] = item.motion_number;
        e["mode"] = item.mode;

        e["cmd_q"] = item.cmd_q;
        e["cmd_dq"] = item.cmd_dq;
        e["cmd_tau"] = item.cmd_tau;
        e["cmd_kp"] = item.cmd_kp;
        e["cmd_kd"] = item.cmd_kd;

        e["state_q"] = item.state_q;
        e["state_dq"] = item.state_dq;
        e["state_ddq"] = item.state_ddq;
        e["state_tau"] = item.state_tau;

        return e;
    }
}

#pragma once

#include <string>
#include <drogon/drogon.h>

namespace Server
{
    struct Connection
    {
        std::string ip;
        int         port;
        std::string client_version; // GUI version
    };
}

namespace drogon
{
    template<>
    Server::Connection fromRequest(const drogon::HttpRequest &req);
}

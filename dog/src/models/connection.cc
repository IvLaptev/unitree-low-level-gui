#include <drogon/drogon.h>
#include <server/models/connection.h>

namespace drogon
{
    template<>
    Server::Connection fromRequest(const drogon::HttpRequest &req)
    {
        auto json = req.getJsonObject();
        Server::Connection connection;

        if (json)
        {
            connection.ip = (*json)["ip"].asString();
            connection.port = (*json)["port"].asInt();
            connection.client_version = (*json)["client_version"].asString();
        }

        return connection;
    }
}

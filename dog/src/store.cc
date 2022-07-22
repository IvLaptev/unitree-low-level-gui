#include <server/store.h>

Server::Store& Server::Store::getData()
{
    static Server::Store instance;
    return instance;
}

std::vector<Server::Motion> Server::Store::getMotions()
{
    if (motions.size())
    {
        auto result = motions[0];

        return result;
    }

    return {};
}

void Server::Store::addMotions(std::vector<Server::Motion> motion_seq)
{
    motions.push_back(motion_seq);
}

void Server::Store::nextMotion()
{
    motions.erase(motions.begin());
}

std::vector<Server::Log> Server::Store::getLogs()
{
    if (logs.size())
    {
        auto result = logs[0];

        return result;
    }

    return {};
}

void Server::Store::createNewLogsGroup()
{
    logs.push_back({});
}

void Server::Store::addLog(Server::Log &log)
{
    logs[logs.size() - 1].push_back(log);
}

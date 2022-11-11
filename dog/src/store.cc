#include <server/store.h>
#include <iostream>

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

Json::Value Server::Store::getLogs()
{
    Json::Value result = {};
    
    if (logs.size())
    {
        auto targetLogs = logs[0];
        

        for (int i = 0; i < targetLogs.size(); i++)
        {
            result[i] = Server::toJson(targetLogs[i]);
        }

        removeUsedLogs();
    }

    return result;
}

void Server::Store::createNewLogsGroup()
{
    logs.push_back({});
}

void Server::Store::addLog(Server::Log &log)
{
    logs[logs.size() - 1].push_back(log);
}

void Server::Store::removeUsedLogs()
{
    logs.erase(logs.begin());
}

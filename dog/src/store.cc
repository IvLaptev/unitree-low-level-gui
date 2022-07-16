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
        motions.erase(motions.begin());

        return result;
    }

    return {};
}

void Server::Store::addMotions(std::vector<Server::Motion> &motion_seq)
{
    motions.push_back(motion_seq);
}

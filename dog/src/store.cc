#include <server/store.h>

Server::Store& Server::Store::getData()
{
    static Server::Store instance;
    return instance;
}

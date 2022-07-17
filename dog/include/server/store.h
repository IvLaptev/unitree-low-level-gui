#pragma once

#include <vector>
#include <server/models/motion.h>

namespace Server
{
    // Singleton storage for sharing information between parts of an application 
    class Store
    {
        // Stores motions from gui app
        std::vector< std::vector<Server::Motion> > motions = {};

        Store() {}
        ~Store() {}
        Store(const Store &);
        Store& operator=(Store &);

    public:
        static Store& getData();

        std::vector<Server::Motion> getMotions();

        void addMotions(std::vector<Server::Motion>);

        void nextMotion();
    };
}

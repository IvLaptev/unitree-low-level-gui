#pragma once

#include <vector>
#include <server/models/motion.h>

namespace Server
{
    // Singleton storage for sharing information between parts of an application 
    class Store
    {
        Store() {}
        ~Store() {}
        Store(const Store &);
        Store& operator=(Store &);
    public:
        std::vector< std::vector<Server::Motion> > motions = {};
        
        static Store& getData();
    };
}

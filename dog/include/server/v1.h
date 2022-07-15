#pragma once

#include <drogon/HttpController.h>
#include <server/models/connection.h>
#include <server/models/motion.h>

namespace Server
{
  // Definition of api requests
  class V1 : public drogon::HttpController<V1>
  {
    public:
      METHOD_LIST_BEGIN
      // Connect client to server and "lock" server
      METHOD_ADD(V1::connect, "/connect", drogon::Post);

      // Set one sequence of motions
      METHOD_ADD(V1::setMotions, "/motions", drogon::Post);

      // // Get logs from robot. Sent data is deleted from robot
      // METHOD_ADD(V1::getData, "/records", drogon::Get);

      METHOD_LIST_END
      
      void connect(const drogon::HttpRequestPtr &req,
                  std::function<void (const drogon::HttpResponsePtr &)> &&callback,
                  Server::Connection &&pConnection);
      
      void setMotions(const drogon::HttpRequestPtr &req,
                  std::function<void (const drogon::HttpResponsePtr &)> &&callback,
                  std::vector<Server::Motion> &&pMotions);
      
      // void getData(const drogon::HttpRequestPtr &req,
      //             std::function<void (const drogon::HttpResponsePtr &)> &&callback);
  };
} // namespace Server

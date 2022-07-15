#include <server/v1.h>
#include <iostream>
#include <vector>

void Server::V1::connect(const drogon::HttpRequestPtr &req,
                  std::function<void (const drogon::HttpResponsePtr &)> &&callback,
                  Server::Connection &&pConnection)
{
    std::cout << pConnection.ip << std::endl;

    auto resp = drogon::HttpResponse::newHttpResponse();
    resp->setStatusCode(drogon::k200OK);
    callback(resp);
}

void Server::V1::setMotions(const drogon::HttpRequestPtr &req,
                  std::function<void (const drogon::HttpResponsePtr &)> &&callback,
                  std::vector<Server::Motion> &&pMotions)
{
    std::cout << unsigned(pMotions[2].leg) << std::endl;

    auto resp = drogon::HttpResponse::newHttpResponse();
    resp->setStatusCode(drogon::k200OK);
    callback(resp);
}
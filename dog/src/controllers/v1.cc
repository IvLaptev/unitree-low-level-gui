#include <server/v1.h>
#include <iostream>

void Server::V1::connect(const drogon::HttpRequestPtr &req,
                  std::function<void (const drogon::HttpResponsePtr &)> &&callback,
                  Server::Connection &&pConnection)
{
    std::cout << pConnection.ip << std::endl;

    auto resp = drogon::HttpResponse::newHttpResponse();
    resp->setStatusCode(drogon::k200OK);
    callback(resp);
}
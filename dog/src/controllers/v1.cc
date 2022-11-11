#include <server/v1.h>
#include <iostream>
#include <vector>
#include <server/store.h>

void Server::V1::connect(const drogon::HttpRequestPtr &req,
                  std::function<void (const drogon::HttpResponsePtr &)> &&callback,
                  Server::Connection &&pConnection)
{
    // TODO: Lock channel
    std::cout << pConnection.ip << std::endl;

    auto resp = drogon::HttpResponse::newHttpResponse();
    resp->setStatusCode(drogon::k200OK);
    callback(resp);
}

void Server::V1::setMotions(const drogon::HttpRequestPtr &req,
                  std::function<void (const drogon::HttpResponsePtr &)> &&callback,
                  std::vector<Server::Motion> &&pMotions)
{
    // Save motions to store
    Server::Store::getData().addMotions(pMotions);
    // std::cout << (pMotions.size()) << std::endl;

    auto resp = drogon::HttpResponse::newHttpResponse();
    resp->setStatusCode(drogon::k200OK);
    callback(resp);
}

void Server::V1::getData(const drogon::HttpRequestPtr &req,
                  std::function<void (const drogon::HttpResponsePtr &)> &&callback)
{
    auto resp = drogon::HttpResponse::newHttpJsonResponse(Server::Store::getData().getLogs());
    resp->setStatusCode(drogon::k200OK);
    callback(resp);
}

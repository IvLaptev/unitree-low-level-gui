#include <drogon/drogon.h>

#include <robot/controller.h>

int main()
{
    Robot::Controller controller;
    
    // Run HTTP server
    drogon::app()
        .loadConfigFile("./config.json")
        .setLogLevel(trantor::Logger::kTrace)
        .setLogPath(".", "log_")
        .run();

    sleep(10000);

    return 0;
}

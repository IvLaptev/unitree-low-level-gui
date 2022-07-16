#include <drogon/drogon.h>

int main()
{
    // Run HTTP server
    drogon::app()
        .loadConfigFile("./config.json")
        .setLogLevel(trantor::Logger::kTrace)
        .setLogPath(".", "log_")
        .run();

    return 0;
}

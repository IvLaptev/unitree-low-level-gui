#include <drogon/drogon.h>
int main() {
    //Set HTTP listener address and port
    drogon::app()
        .addListener("0.0.0.0",80)
        .loadConfigFile("../config.json")
        .run();

    return EXIT_SUCCESS;
}

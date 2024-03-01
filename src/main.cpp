#include <fstream>

#include "azure_iot/client_iot.hpp"
#include "iotb/app.hpp"
#include "nlohmann/json.hpp"

using namespace std::chrono_literals;

int main()
{
    auto azure_client = std::make_shared<azure_iot::ClientIot>();
    std::ifstream config_file("/var/config/main_config.json");

    iotb::App app(azure_client,
                  nlohmann::json::parse(config_file));
    app.initDefaultLogger("logs/logs.txt", 1'000'000, 5, 5s);
    app.init();
    app.start();
}
# Unitree low-level control app
[[ru](./README_ru.md), [en](./README.md)]

> Desktop application for low-level control of Unitree robots. Currently only support for **Unitree A1** robots is available

## Description

This application allows you to send low-level commands to the robot. There is **no need** to edit, compile and constantly re-run the code on the robot to execute your commands.

The solution consists of two parts:

*   Server side

    This component runs on one of the robot's on-board computers. It accepts the client's commands, transforms them into a form understandable to the robot, and forwards them to the robot.

*   GUI

    Commands sent to the robot are formed on the client side (GUI).

Supported control modes:

- [x] Position mode
- [ ] Velocity mode
- [ ] Torque mode 
- [ ] Compound mode

## Run

You are able to:
* Download apps and run them
* Build your own apps from sources

### Building from sources

#### Requirements

**Server**

*   С++ compler supporting С++ 17
*   [CMake](https://cmake.org/install) (3.5 or higher)
*   [Drogon](https://drogon.docsforge.com/master/installation) (использовалась 1.7.5)
*   [Boost](https://www.boost.org/doc/libs/1_79_0/more/getting_started/unix-variants.html) (1.61.0 or higher)
*   [LCM](https://lcm-proj.github.io/build_instructions.html) (1.4.0 or higher)

#### Build

**Server**

*   Run the following commands in terminal:

    ```bash
    cd ./dog
    mkdir build
    cd ./build
    cmake ..
    make
    ```

#### Run

**Server**

*   Create file `config.json` with server configuration in `robot-low-level-backend`. Example:

    ```json
    {
        "listeners": [
            {
                "adreess": "0.0.0.0",
                "port": 5000,
                "https": false
            }
        ],
        "app": {
            "number_of_threads": 2,
            "server_header_field": ""
        }
    }
    ```

*   To run application execute:

    ```bash
    sudo ./robot-low-level-backend
    ```


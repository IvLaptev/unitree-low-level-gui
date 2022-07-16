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

## Run

You are able to:
* Download apps and run them
* Build your own apps from sources

### Building from sources

# 🚦 Traffic Light Control System

Welcome to the Traffic Light Control System project! This project is designed to control a set of traffic lights using a PIC16F877A microcontroller. It features both automatic and manual modes of operation, allowing the user to simulate traffic light sequences in a way that is both practical and educational.

## 📋 Project Description

This project simulates a traffic light system with two sets of traffic lights, each consisting of red, yellow, and green LEDs. The system is designed to operate in two main modes:

- **Automatic Mode**: The lights change according to a pre-programmed sequence, mimicking the behavior of real traffic lights.
- **Manual Mode**: The user can manually cycle through the lights using a button, providing more control for testing or demonstration purposes.

## 💻 Code Features

- **Port Definitions**: The code defines the pins used for the traffic light LEDs, making it easy to reconfigure if the hardware setup changes.

    ```cpp
    #define ledR1 portd.b0
    #define ledY1 portd.b1
    #define ledG1 portd.b2
    #define ledR2 portd.b3
    #define ledY2 portd.b4
    #define ledG2 portd.b5
    ```

- **Automatic Mode**: The `automatic_mode` function controls the lights in a sequence, simulating the traffic flow at an intersection. The sequence includes a countdown feature to signal when the lights will change.

- **Manual Mode**: The `manual_mode` function allows the user to manually cycle through the traffic light states using a button. This mode is useful for testing and demonstrations.

- **Interrupt Handling**: The system uses an interrupt to switch to manual mode, ensuring that the user can take control at any time without disrupting the main operation.

- **State Management**: The code uses global variables to manage the state of the lights and control the flow of the program.

## 🛠️ Hardware Setup

This project is designed for use with a PIC16F877A microcontroller. The LEDs are connected to `PORTD`, and the buttons for mode selection and LED cycling are connected to `PORTB`.

### Pin Connections:

- **LEDs**:
    - Red Light 1: `PORTD.B0`
    - Yellow Light 1: `PORTD.B1`
    - Green Light 1: `PORTD.B2`
    - Red Light 2: `PORTD.B3`
    - Yellow Light 2: `PORTD.B4`
    - Green Light 2: `PORTD.B5`
- **Buttons**:
    - Manual Mode Trigger: `PORTB.B0`
    - LED Cycle Button: `PORTB.B1`

## 📜 How to Use

1. **Clone the Repository**:

    ```sh
    git clone https://github.com/yourusername/traffic-light-control.git
    cd traffic-light-control
    ```

2. **Compile and Upload** the code to your PIC16F877A microcontroller using your preferred IDE (e.g., MPLAB X).

3. **Connect the Hardware** as described in the Hardware Setup section.

4. **Run the System**:
    - The system will start in automatic mode by default.
    - Press the button connected to `PORTB.B0` to enter manual mode and cycle through the lights using the button connected to `PORTB.B1`.

## 📁 File Structure

- **`main.c`**: The main code file containing the traffic light control logic.
- **`README.md`**: This file, providing an overview of the project and instructions for use.

## 📖 Future Enhancements

- Add support for pedestrian crossing signals.
- Implement a more sophisticated timing algorithm for the automatic mode.
- Integrate with a real-time clock module for more accurate timing.


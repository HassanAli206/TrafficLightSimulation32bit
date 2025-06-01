TrafficLightSimulation32bit

A simple 32-bit traffic light simulator written in MASM (Microsoft Macro Assembler), integrated with the Irvine32 library, which simplifies interaction with I/O operations. This project simulates a traffic light system with configurable red, yellow, and green phases, including a visual display and countdown timer.

Overview

This project implements a console-based traffic light simulation that cycles through red, yellow, and green phases. Users can input custom durations (between 1 and 9 seconds) for each phase. The simulation includes:
	A graphical representation using ASCII characters.
	A countdown timer and progress bar for each phase.
	Keyboard interrupt to exit the simulation.

The code is assembled and run using Visual Studio with the MASM assembler and Irvine32 library.

Features
	Configurable phase durations via user input.
	Visual feedback with colored lights (red, yellow, green) and a progress bar.
	Real-time countdown display.
	Exit option by pressing any key.

Prerequisites

To build and run this project, you need the following:

	Visual Studio: Any recent version (e.g., 2019 or 2022) with the Desktop Development with C++ workload installed.
	MASM (Microsoft Macro Assembler): Included with Visual Studio.
Irvine32 Library: Download the Irvine32 library from the official source (e.g., Kip Irvine’s website or included with the textbook "Assembly Language for x86 Processors"). Place the `Irvine32.inc` and related `.lib` files in your project directory or configure the include/library paths in Visual Studio.
Windows OS: The code is written for a 32-bit Windows environment.

Installation

1. Clone the Repository:
   
   git clone https://github.com/HassanAli206/TrafficLightSimulation32bit.git
   cd TrafficLightSimulation32bit

2. Set Up the Irvine32 Library:
   	Download the Irvine32 library if not already included.
   	Copy `Irvine32.inc`, `Irvine32.lib`, and `kernel32.lib` to the project directory or configure Visual Studio to include them:
     	Right-click the project in Solution Explorer > Properties > VC++ Directories.
     	Add the paths to `Include Directories` and `Library Directories`.

3. Open the Solution:
   	Open the `.sln` file in Visual Studio.
   	Ensure the project is set to build as a 32-bit application (Project Properties > General > Platform Target: x86).

4. Build the Project:
   	Build the solution (Build > Build Solution or press F7).
   	Resolve any linker errors by ensuring the Irvine32 library is correctly linked (Project Properties > Linker > Input > Additional Dependencies: add `Irvine32.lib`).

5. Run the Program:
   	Run the application (Debug > Start Debugging or press F5).
   	Follow the prompts to enter phase durations and start the simulation.

Usage
1. Input Phase Durations:
   	The program prompts for red, yellow, and green light durations (1-9 seconds).
   	If invalid input is provided, it defaults to 5 seconds (red), 3 seconds (yellow), and 4 seconds (green).

2. Start the Simulation:
   	Press any key after entering durations to begin.
   	The screen displays the current phase (RED, YELLOW, or GREEN) with a colored light and countdown.

3. Exit the Simulation:
   	Press any key during the simulation to exit.

Code Structure

Main Program (`main PROC`):
  	Handles the main loop, switching between phases based on `timer_state`.
ShowLight PROC:
  	Displays the light, countdown, and progress bar, with a 1-second delay.
ShowLightFrame PROC:
	Draws the ASCII frame around the light.
ShowPhaseName PROC:
  	Displays the current phase name.
GetTimeInput PROC:
  	Collects user input for phase durations with validation.

Contributing

1. Fork the repository.
2. Create a feature branch (`git checkout -b feature/new-feature`).
3. Commit your changes (`git commit -m "Add new feature"`).
4. Push to the branch (`git push origin feature/new-feature`).
5. Open a pull request on GitHub.

License

This project is licensed under the Unlicense license. See the `LICENSE` file for details.

Acknowledgments

	Inspired by the Irvine32 library and the teachings from "Assembly Language for x86 Processors" by Kip Irvine.
	Thanks to the GitHub community for version control support.

Contact

For questions or suggestions, feel free to open an issue on the GitHub repository or contact the maintainer.

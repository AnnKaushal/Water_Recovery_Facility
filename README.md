# Water_Recovery_Facility
In this project, I simulate a Microbial Fuel Cell (MFC) system that aims to model the electrochemical and biological processes within the MFC and analyze its energy generation and substrate consumption over time.

# Design of an Energy-Positive Water Resource Recovery Facility using MFCs

## Description

This MATLAB project is a simulation of a Microbial Fuel Cell (MFC) system that aims to model the electrochemical and biological processes within the MFC and analyze its energy generation and substrate consumption over time.

## Author

- **Author:** Anandita Kaushal
- **Contact:** 20bce034@nith.ac.in

---

## Getting Started

To run this project, follow the steps below:

1. Open MATLAB and create a new script or function file.

2. Copy and paste the code from this README into the script or function file.

3. Run the script or function file to perform the simulation of the MFC system.

---

## Project Overview

The project begins by defining various parameters that govern the MFC system's behavior. These include simulation time, time step, number of MFC cells, substrate concentration, wastewater flow rate, anode and cathode surface areas, electrochemical properties (internal resistance, open circuit voltage, conversion factor), and biological properties (maximum specific growth rate, yield coefficient, decay coefficient).

---

## Simulation Process

The simulation proceeds in a loop over time steps. Within each time step, the biological and electrochemical processes are simulated.

1. **Biological Processes:**
   - Changes in substrate concentration and biomass concentration are calculated based on biological processes.
   - Substrate consumed and biomass decay are determined.
   - Substrate concentration and biomass concentration are updated.

2. **Electrochemical Processes:**
   - For each MFC cell, the current is computed using the difference between the open circuit voltage and the voltage across the cell's internal resistance.
   - Power generation is calculated using the simplified approach of voltage multiplied by current.
   - The voltage across the cell is updated based on electrochemical behavior.

3. **Results Calculation:**
   - Total energy generated and total substrate consumed over the entire simulation are calculated based on generated power and substrate concentration changes.
   - Total energy consumed for biomass growth over time is calculated based on growth rate, substrate concentration, and yield coefficient.
   - Net energy balance is determined by subtracting the energy consumed for biomass growth from the total energy generated.

---

## Results

The project provides the following results:

- Substrate Concentration Over Time
- Biomass Concentration Over Time
- MFC Power Generation Over Time
- Energy Balance Over Time

The net energy balance is also displayed, which indicates whether the MFC system is energy-positive or not.

---

## References

- No external references are required for this project as it is a self-contained MATLAB script for simulating an energy-positive water resource recovery facility using MFCs.

---

**Note:** Please ensure that you have MATLAB installed to run this project successfully.

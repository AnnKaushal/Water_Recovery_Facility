% -------------------------------------------------------------------------
% Project Title: Design of an Energy-Positive Water Resource Recovery 
%                Facility using MFCs.
%
% Description: This MATLAB project is a simulation of a Microbial Fuel Cell 
% (MFC) system that aims to model the electrochemical and biological 
% processes within the MFC and analyze its energy generation and substrate 
% consumption over time. 
%
% Author: Anandita Kaushal
% Contact: 20bce034@nith.ac.in
% -------------------------------------------------------------------------

% Get started on a clean command window 
clc

% Define parameters

% The project begins by defining various parameters that govern the MFC 
% system's behavior. These include simulation time, time step, number of
% MFC cells, substrate concentration, wastewater flow rate, anode and 
% cathode surface areas, electrochemical properties (internal resistance, 
% open circuit voltage, conversion factor), and biological properties 
% (maximum specific growth rate, yield coefficient, decay coefficient).

timeSpan = 100;                % Simulation time (hours)
timeStep = 1;                  % Time step (hours)
numCells = 10;                 % Number of MFC cells
substrateConcentration = 2000; % Substrate concentration (mg/L)
wastewaterFlowRate = 1000;     % Wastewater flow rate (L/hour)
anodeArea = 0.01;              % Anode surface area (m^2)
cathodeArea = 0.01;            % Cathode surface area (m^2)

% Electrochemical properties
Rint = 50;                  % Internal resistance (Ohms)
Voc = 0.8;                  % Open circuit voltage (Volts)
n = 0.8;                    % Cell voltage conversion factor

% Biological properties
maxSpecificGrowthRate = 0.2; % Maximum specific growth rate (1/hour)
yieldCoefficient = 0.4;      % Substrate to biomass yield coefficient
decayCoefficient = 0.01;     % Decay coefficient (1/hour)

% Initialize variables and arrays
time = 0:timeStep:timeSpan;
voltage = zeros(numCells, length(time));
current = zeros(numCells, length(time));
power = zeros(numCells, length(time));
substrateConcentrationArray = zeros(1, length(time));
biomassConcentrationArray = zeros(1, length(time));

% Simulate MFC operation

% The simulation proceeds in a loop over time steps. Within each time step, 
% the biological and electrochemical processes are simulated.

substrateConcentrationArray(1) = substrateConcentration;
biomassConcentrationArray(1) = 10; % Initial biomass concentration

for t = 1:length(time)-1
    % Biological processes

    % Within each time step, the changes in substrate concentration and 
    % biomass concentration are calculated based on biological processes.

    substrateConsumed = maxSpecificGrowthRate * biomassConcentrationArray(t) * substrateConcentrationArray(t) / (yieldCoefficient + substrateConcentrationArray(t)) * timeStep;
    biomassDecay = decayCoefficient * biomassConcentrationArray(t) * timeStep;
    
    substrateConcentrationArray(t+1) = substrateConcentrationArray(t) - substrateConsumed;
    biomassConcentrationArray(t+1) = biomassConcentrationArray(t) + (substrateConsumed - biomassDecay);
    
    % Electrochemical processes

    % For each MFC cell, the current is computed using the difference b/w
    % the open circuit voltage and the voltage across the cell's internal 
    % resistance. Power generation is calculated using the simplified approach 
    % of voltage multiplied by current. The voltage across the cell is 
    % updated based on electrochemical behavior.

    for cell = 1:numCells
        current(cell, t) = (Voc - voltage(cell, t)) / Rint;
        
        % Calculate power based on electrochemical behavior (a simplified approach)
        power(cell, t) = voltage(cell, t) * current(cell, t);
        
        % Update voltage based on electrochemical behavior
        voltageChange = (current(cell, t) * Rint - n * voltage(cell, t)) * timeStep;
        voltage(cell, t+1) = voltage(cell, t) + voltageChange;
    end
end

% Calculate total energy generated and substrate consumed over time

% The total energy generated and total substrate consumed over the entire 
% simulation are calculated based on the generated power and substrate 
% concentration changes.

totalEnergyGenerated = sum(sum(power)) * timeStep;
totalSubstrateConsumed = sum(substrateConcentrationArray) * wastewaterFlowRate * timeStep / 1000; % Convert to kg

fprintf('Total energy generated: %.2f Joules\n', totalEnergyGenerated);
fprintf('Total substrate consumed: %.2f kg\n', totalSubstrateConsumed);

% Calculate total energy consumed for biomass growth over time
totalEnergyConsumed = sum(biomassConcentrationArray .* maxSpecificGrowthRate .* substrateConcentrationArray ./ (yieldCoefficient + substrateConcentrationArray) .* timeStep) .* wastewaterFlowRate .* timeStep / 1000; % Convert to kWh

% Calculate net energy balance

% The energy consumed for biomass growth over time is calculated based on 
% growth rate, substrate concentration, and yield coefficient. The net 
% energy balance is then determined by subtracting the energy consumed for
% biomass growth from the total energy generated.

netEnergyBalance = totalEnergyGenerated - totalEnergyConsumed;

fprintf('Total energy generated: %.2f Joules\n', totalEnergyGenerated);
fprintf('Total substrate consumed: %.2f kg\n', totalSubstrateConsumed);
fprintf('Total energy consumed for biomass growth: %.2f kWh\n', totalEnergyConsumed);
fprintf('Net energy balance: %.2f kWh\n', netEnergyBalance);

% Plot substrate concentration
figure;
plot(time, substrateConcentrationArray);
xlabel('Time (hours)');
ylabel('Substrate Concentration (mg/L)');
title('Substrate Concentration');

% Plot biomass concentration
figure;
plot(time, biomassConcentrationArray);
xlabel('Time (hours)');
ylabel('Biomass Concentration');
title('Biomass Concentration');

% Plot power generation
figure;
plot(time, power);
xlabel('Time (hours)');
ylabel('Power Generated (W)');
title('MFC Power Generation');

% Plot energy balance
figure;
plot(time, cumsum(power .* timeStep) - cumsum(biomassConcentrationArray .* maxSpecificGrowthRate .* substrateConcentrationArray ./ (yieldCoefficient + substrateConcentrationArray) .* timeStep .* wastewaterFlowRate .* timeStep ./ 1000));
xlabel('Time (hours)');
ylabel('Energy Balance (kWh)');
title('Energy Balance Over Time');
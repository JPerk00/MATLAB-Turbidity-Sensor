%% Turbidity Sensor Calibration Script
% Created by: Portland Community College Students in ENGR 114 Winter 2018
% Revised on: 3/15/18
% Description: This script prompts the user to place the turbidity sensor
%              in a reference solution to establish a baseline voltage.
%              This is used to generate a relationship between voltage
%              and NTUs (Nephelometric Turbidity Units)

%% 
clc, clear all, close all;

%% Set up serial port and ensure it outputs data
% Change to the port the Arduino is connected to

Port = 'COM3';                % Port the Arduino is connected to
delete(instrfindall);         % Deletes any connected ports
a = serial(Port);             % Connect to the arduino in order to read information 
fopen(a);                     % Opens the serial port
pause(1);                     % Pause for 1 second to make sure a connection is made
out1 = instrfind('Port',Port); % See if any Ports are open
out = fscanf(a);              % Read one time from the serial port

%% Prompt user with relevant data, and validate sensor placement
fprintf('Place the sensor into still deionized water to establish a zero point NTU reading.');
reply = 'N';
while strcmpi(reply,'Y')==0
    reply = input('\nIs sensor in place? Y/N [Y]: ','s');
       if isempty(reply)
          reply = 'Y';        % Default to 'Y' for single enter press
       end
end
fprintf('\nPlease keep sensor in place for 10 seconds to stabilize...');

%% Take voltage measurements
saved_data = [];
for i=1:10
        data = fscanf(a, '%s');             % Reads the data from the arduino code
        data = str2num(data);               % Converts the data to a number from a string
        saved_data(end+1) = data;           % Logs the data for all the points
        pause(1);
end
volt_mean = sum(saved_data) / numel(saved_data);        % Calculate the mean
fprintf('\nVoltage mean: %4.3f\n', volt_mean);
%% Arduino Group Project: Read Serial Data from Arduino & Upload to ThingSpeak
% Revised by: Portland Community College Students in ENGR114 Winter 2018
% Revised on: 3/15/18
% Description: Reads serial data and plots in real time. This code collects
%              data from Arduino for the turbidity level read by a sensor.
%              User selects duration of live data plot
%%
clc, clear all, close all;

duration = input('Enter duration of run time (in seconds): ');

%% Set up serial port and ensure it outputs data
% Change to the port the Arduino is connected to

Port = 'COM3';                % Port the Arduino is connected to
delete(instrfindall);         % Deletes any connected ports
a = serial(Port);             % Connect to the arduino in order to read information 
fopen(a);                     % Opens the serial port
pause(1);                     % Pause for 1 second to make sure a connection is made
out1 = instrfind('Port',Port);% See if any ports are open
out = fscanf(a);              % Read one time from the serial port

%% Set up the animated figure

figure                       % Creates a figure to plot the data
h = animatedline;            % Line that plots in the figure
ax = gca;                    % Returns the handle to the current axis in the current figure
ax.YGrid = 'on';             % Creates grid line on the Y-axis only
ax.YLim = [0 100];           % The output range
xlabel('Time (seconds)');    % Creates the X-axis label in the graph
ylabel('NTU (Nephelometric Turbidity Units)');      % Creates the Y-axis label in the graph
title('Turbidity Readings'); % Creates the title for the graph

%% Set up the serial data to run

x = linspace(1,duration,duration);  % can change to alter the number of data points 
startTime = datetime('now');        % Starts the readings at the current time
saved_data = [];                    % Stores the data recorded

%   Clear the command window of user inputs to make way for counter
clc;

%% ThingSpeak.com Parameters

ThingSpeak_channel = 435269; %% Unique ThingSpeak Channel (Integer)
ThingSpeak_API_write_key = 'G8ZSAVUN0EN9H1W7';  %% Unique ThingSpeak API Write Key (String)

%% Collect serial data, Live plot data points
bbb = 0;
turb_mean = [];
for i=1:length(x)
        data = fscanf(a, '%s');             % Reads the data from the arduino code
        data = str2num(data);               % Converts the data to a number from a string
        data = 336.48 * data^2 - 3250 * data + 7727.8;
        % Converts to NTU using equation developed in calibration & testing
        % This can be changed according to part/sensor used
        saved_data(end+1) = data;           % Logs the data for all the points
        t = datetime('now') - startTime;    % Updates the time
        addpoints(h,datenum(t),data)        % Adds the data point to the figure
        ax.XLim = datenum([0 t]);           % Updates the axis window as it runs 
        datetick('x','keeplimits')          % Changes tick labels into data-based labels while preserving axis limits.   
        drawnow                             % Allows you to see the updates immediately in the figure
       
        if mod(i,20)==0    % Uploads every 20 seconds
            % Calculate the mean of the data and upload it to ThingSpeak
            turb_mean = sum(saved_data) / numel(saved_data);        % Calculate the mean
            fprintf('\nTurbidity mean (NTU): %3.0f\n', turb_mean);
            thingSpeakWrite(ThingSpeak_channel,turb_mean,'WriteKey',ThingSpeak_API_write_key)   % Uploads within the loop
        end
    pause(1)
    % count-up of seconds inline
    clc;
    fprintf('Last Turbidity mean: %3.0f\n',turb_mean)
    msg = ['Elapsed time: ',num2str(i),' seconds...'];
    fprintf(msg);fprintf('\n');
    bbb=numel(msg);
end


%% Shut down the serial port from the Arduino RedBoard

fclose(a);      % Closes the serial port
delete(a)       % Deletes the serial port
clear a;        % Clears the serial port 
# MATLAB-Turbidity-Sensor
A student project for ENGR114 at Portland Community College. Uses MATLAB to read a turbidity sensor connected to an Arudino over serial.
# Problem Statement
Our group was tasked with creating MATLAB code to call data from an Arduino hooked up to a
turbidity sensor for the hydroponic fish tank-garden in the engineering department. 
Using Arduino and MATLAB the water turbidity produced from a TSW-10
Turbidity Sensor will produce measurements that will be uploaded to ThingSpeak via MATLAB where progressive turbidity data will be stored and plotted against time for any necessary reference. A plot of the turbidity as a function of time will also be generated for a visual representation of the turbidity. The Arduino will produce an analog reading for turbidity that is converted to a voltage reading (where more voltage is less turbid water), then which MATLAB outputs the NTU reading for correct tubidity units.
# Hardware Setup

### Bill of Materials
|component|vendor|
|---|---|
|Arduino|[SparkFun RedBoard - Programmed with Arduino](https://www.sparkfun.com/products/13975)|
|Turbidity Sensor|[Gravity Analog Turbidity Sensor](https://www.robotshop.com/en/gravity-analog-turbidity-sensor.html)|
|Jumper wires|[Jumper Wires Premium 6" M/M Pack of 10](https://www.sparkfun.com/products/8431 )|
|Mini-B USB cable|[SparkFun USB Mini-B Cable - 6 Foot](https://www.sparkfun.com/products/11301)|
|3D-Print Boat Template|[Thingiverse](https://www.thingiverse.com/thing:1466370)|

## Fritzing Diagram

## Connected Hardware
![Full Setup](https://github.com/JPerk00/MATLAB-Turbidity-Sensor/blob/master/Setup.png)
## Arduino Code
The [turb_sens_1_2.ino](turb_sens_1_2.ino) script was run in Arduino.
## MATLAB Code
The [NTU_code_3_15.m](NTU_code_3_15.m) script was run in MATLAB.
## Results
![Turbidity vs. Time](https://github.com/JPerk00/MATLAB-Turbidity-Sensor/blob/master/Capture4Jeff.PNG)
## Future Work
Future work for the turbidity sensor could involve integrating the temperature sensor to dial into a more accurate reading as there is a correlation between turbidity and temperature. Adding a wifi shield would be a helpful component as well and eliminate the need for a laptop to be present at the fish tank.  Turbidity effects the fish health, cleaner water produces healthier fertilization, healthier feritilization results in healthier plants, healthier plants results in better fruit production, and so forth.
## License
GNU General Public License v3.0

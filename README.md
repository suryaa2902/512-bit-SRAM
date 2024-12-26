# 512-bit-SRAM
A 512-bit SRAM Cell

The Verilog (.v) file above has the primary code for the working of the SRAM Cell and a testbench to test the simulation

This project was initially created as a schematic using **Cadence Virtuoso**.

SRAM array with 512 cells having sizing as 100:150:230 [Wpu:Wax:Wpd] was designed. 4x16 dynamic decoder was designed to decode the WL from the address latched from the MSB of 6-bit dynamic transmission gate address registers. 

## The SRAM System
<img width="652" alt="image" src="https://github.com/user-attachments/assets/85fc81c3-1480-4acf-aba5-14753710f59e" />

## DFF Design Schematic
![image](https://github.com/user-attachments/assets/440c1d93-23e6-4226-a017-c75363ef0fd6)

The registers (Address, Read, and Write) are created using DFFs in a Master-Slave configuration. 

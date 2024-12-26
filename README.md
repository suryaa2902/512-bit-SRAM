# 512-bit-SRAM
A 512-bit SRAM Cell

The Verilog (.v) file above has the primary code for the working of the SRAM Cell and a testbench to test the simulation. This code is an attempt at replicating the working of an SRAM cell created using Cadence Virtuoso.

This project was initially created as a schematic using **Cadence Virtuoso**.

SRAM array with 512 cells having sizing as 100:150:230 [Wpu:Wax:Wpd] was designed. 4x16 dynamic decoder was designed to decode the WL from the address latched from the MSB of 6-bit dynamic transmission gate address registers. 

## The SRAM System
<img width="652" alt="image" src="https://github.com/user-attachments/assets/85fc81c3-1480-4acf-aba5-14753710f59e" />

## Decoder Design

A 4x16 row decoder is designed using NAND-NOR based hierarchical 2x4 decoder chain to address the 16 word lines. The 2 MSB address bits are decoded in the first NAND-based static 2:4 decoder which pre-decodes the enable signals for the subsequent decoder stage. The second NOR-based dynamic decoder 2x4 stage decodes the WL to be activated. Dynamic decoder reduces the delay through the row decoder since the WL should be in sync with the clock. Static NAND decoder is used at the first stage to avoid the design challenge of cascading dynamic gates which may result in glitches leading to wrong sensing. A 2x4 static conventional NOR decoder is used to decode the LSB bits of the address. The output of the decoder drives the 4:1 transmission gate MUX with equally sized pmos and nmos (length 45nm, width 90nm).

![image](https://github.com/user-attachments/assets/58f70dfe-a0c1-4a6d-a25c-22e46099e8f8)

## Register Design

Dynamic transmission gate positive edge triggered master-slave D flip flop is used to latch the address and data bits. When the clock is 0, the first stage transmission gate is turned on and the applied data is sampled and stored at the node after the first transmission gate. At the positive edge of the clock, the second stage transmission gate is on and the address bit is sampled at the output. In the transmission gate, NMOS and PMOS are sized equally since they aid each other and PMOS passes logic 1 and NMOS logic 0. The registers (Address, Read, and Write) are created using DFFs in a Master-Slave configuration. 

**DFF Design Schematic**

![image](https://github.com/user-attachments/assets/5de817d7-3f4c-4e3a-92cb-347d1207ea60)

**SRAM Cell Parameters**

![image](https://github.com/user-attachments/assets/47c164f4-245f-44a0-85e4-9f6bf3abce40)

**Write Margin with varying Widths**

![image](https://github.com/user-attachments/assets/b5b09522-0e8d-4b42-b6ac-ba4518948f6b)



